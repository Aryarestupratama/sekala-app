import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../providers/auth_providers.dart';

/// Design.md §3.1 + §5.2 — layar Masuk/Daftar.
///
/// REVISI (design review):
/// - Layout: `FittedBox` + scroll dimatikan diganti scroll normal yang sadar
///   keyboard (keyboard terbuka / font 200% tidak lagi memotong tombol).
/// - Kontras: hint, border field, dan teks syarat dinaikkan ke WCAG AA
///   (teks >= 4.5:1, border komponen >= 3:1). Fokus = border Ink 2px.
/// - Ukuran: teks input 16, semua target sentuh >= 48.
/// - Error: inline di bawah field (bukan di dalam pill) + kotak error form
///   untuk error server. Snackbar tidak dipakai lagi untuk error/sukses.
/// - Daftar berhasil: notifikasi PERSISTEN (bukan snackbar 5 detik).
/// - Konfirmasi kata sandi dihapus (toggle lihat-sandi sudah ada); backend
///   tetap menerima `passwordConfirmation` = sandi yang sama.
/// - "Lupa kata sandi?" DIHAPUS sementara (sebelumnya tombol mati). Kembalikan
///   setelah endpoint reset password ada.
/// - Autofill (AutofillGroup + hints), reduce-motion, semantics dasar.
///
/// Logic (auth provider, alur submit, guest) tidak berubah.
///
/// [onOpenTerms]: isi dari router kalau halaman Syarat & Ketentuan sudah ada.
/// Kalau null, teks syarat tampil biasa (bukan link).
///
/// CATATAN WARNA: ganti konstanta `_k*` dengan `AppColors.*` kalau sudah ada.
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, this.onOpenTerms});

  final VoidCallback? onOpenTerms;

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

enum _AuthMode { login, register }

// Design.md §5.2 — Ink & netral. Rasio kontras dihitung dari hex (estimasi
// manual; verifikasi ulang dengan contrast checker).
const _kInk = Color(0xFF0C0C0C);
const _kBgLight = Color(0xFFF7F7F8);
const _kFieldFill = Colors.white;
const _kTextSecondary = Color(0xFF4B5563); // ~7.5:1 di atas putih
const _kHintGrey = Color(0xFF6B7280); // ~4.8:1 di atas putih
const _kBorder = Color(0xFF8A8A8A); // ~3.4:1 putih, ~3.2:1 di atas bg
const _kError = Color(0xFFB3261D); // ~6.5:1 di atas putih
const _kErrorBg = Color(0xFFFDECEA);
const _kSuccessBg = Color(0xFFEAF6ED);
const _kSuccessIcon = Color(0xFF2E7D45);

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _AuthMode _mode = _AuthMode.login;
  bool _obscurePassword = true;
  bool _autoValidate = false;

  /// Error level-form (mis. kredensial salah, error validasi dari server).
  String? _formError;

  /// Terisi setelah Daftar berhasil; tampil persisten di mode Masuk.
  String? _registeredEmail;

  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  bool _entranceStarted = false;

  // Dibuat sekali (bukan tiap build) supaya tidak menumpuk listener.
  late final Animation<double> _aHeader = _slot(0.0, 0.6);
  late final Animation<double> _aSwitcher = _slot(0.05, 0.5);
  late final Animation<double> _aFields = _slot(0.15, 0.7);
  late final Animation<double> _aSubmit = _slot(0.3, 0.9);
  late final Animation<double> _aGuest = _slot(0.4, 1.0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_entranceStarted) return;
    _entranceStarted = true;
    // Hormati "reduce motion" / animasi dimatikan dari sistem.
    if (MediaQuery.disableAnimationsOf(context)) {
      _entrance.value = 1;
    } else {
      _entrance.forward();
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Animation<double> _slot(double begin, double end) {
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  Duration _dur(int ms) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : Duration(milliseconds: ms);

  void _setMode(_AuthMode mode) {
    setState(() {
      _mode = mode;
      _formError = null;
      _autoValidate = false;
      if (mode == _AuthMode.register) _registeredEmail = null;
    });
  }

  void _clearFormError() {
    if (_formError != null) setState(() => _formError = null);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() => _formError = null);

    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidate = true);
      return;
    }

    final controller = ref.read(authControllerProvider.notifier);
    if (_mode == _AuthMode.login) {
      setState(() => _registeredEmail = null);
      await controller.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted && !ref.read(authControllerProvider).hasError) {
        TextInput.finishAutofillContext();
      }
      // Redirect ke /home ditangani guard di app_router.dart.
    } else {
      final success = await controller.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        // Konfirmasi dihapus dari UI; backend tetap menerima nilai yang sama.
        passwordConfirmation: _passwordController.text,
      );
      // Register TIDAK auto-login (R-AUTH-02): alihkan ke Masuk dengan
      // notifikasi persisten (bukan snackbar yang hilang dalam 5 detik).
      if (success && mounted) {
        TextInput.finishAutofillContext();
        _clearFormForLogin();
      }
    }
  }

  void _clearFormForLogin() {
    setState(() {
      _mode = _AuthMode.login;
      _registeredEmail = _emailController.text.trim();
      _autoValidate = false;
      _formError = null;
      _nameController.clear();
      _passwordController.clear();
      // Email sengaja dibiarkan terisi.
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email wajib diisi';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Format email tidak valid';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Kata sandi wajib diisi';
    if (_mode == _AuthMode.register && value.length < 8) {
      return 'Kata sandi minimal 8 karakter';
    }
    return null;
  }

  String _formatApiError(ApiException error) {
    if (error.isValidationError) {
      final messages = error.validationErrors!.values
          .where((list) => list.isNotEmpty)
          .map((list) => list.first.toString())
          .toList();
      if (messages.isNotEmpty) return messages.join('\n');
    }
    return error.message;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final isRegister = _mode == _AuthMode.register;
    final headerHeight =
        (MediaQuery.sizeOf(context).height * 0.24).clamp(120.0, 200.0);

    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          if (!mounted) return;
          setState(() {
            _formError = error is ApiException
                ? _formatApiError(error)
                : 'Terjadi kesalahan. Silakan coba lagi.';
          });
        },
      );
    });

    return Scaffold(
      backgroundColor: _kBgLight,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Reveal(
                    animation: _aHeader,
                    dy: -24,
                    child: _Header(height: headerHeight),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Form(
                      key: _formKey,
                      child: AutofillGroup(
                        child: _buildFormFields(isRegister, isLoading),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _Reveal(animation: _aGuest, child: _buildTerms()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(bool isRegister, bool isLoading) {
    final autovalidate = _autoValidate
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Reveal(
          animation: _aSwitcher,
          child: _ModeSwitcher(
            mode: _mode,
            isLoading: isLoading,
            duration: _dur(260),
            onChanged: _setMode,
          ),
        ),

        if (_registeredEmail != null && !isRegister) ...[
          const SizedBox(height: 14),
          _RegisteredNotice(email: _registeredEmail!),
        ],
        const SizedBox(height: 18),

        _Reveal(
          animation: _aFields,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nama (hanya mode Daftar)
              AnimatedSize(
                duration: _dur(240),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: isRegister
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _Labeled(
                          label: 'Nama',
                          child: _AuthField(
                            controller: _nameController,
                            hint: 'Nama lengkap kamu',
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            autofillHints: const [AutofillHints.name],
                            autovalidateMode: autovalidate,
                            onChanged: (_) => _clearFormError(),
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                    ? 'Nama wajib diisi'
                                    : null,
                          ),
                        ),
                      )
                    : const SizedBox(width: double.infinity),
              ),

              // Email
              _Labeled(
                label: 'Email',
                child: _AuthField(
                  controller: _emailController,
                  hint: 'nama@email.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  autovalidateMode: autovalidate,
                  onChanged: (_) => _clearFormError(),
                  validator: _validateEmail,
                ),
              ),
              const SizedBox(height: 14),

              // Kata sandi
              _Labeled(
                label: 'Kata Sandi',
                child: _AuthField(
                  controller: _passwordController,
                  hint: 'Masukkan kata sandi',
                  helperText: isRegister ? 'Minimal 8 karakter' : null,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: [
                    isRegister
                        ? AutofillHints.newPassword
                        : AutofillHints.password,
                  ],
                  autovalidateMode: autovalidate,
                  onChanged: (_) => _clearFormError(),
                  onFieldSubmitted: (_) => _submit(),
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    tooltip: _obscurePassword
                        ? 'Tampilkan kata sandi'
                        : 'Sembunyikan kata sandi',
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 22,
                      color: _kTextSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (_formError != null) ...[
          const SizedBox(height: 14),
          _ErrorBox(message: _formError!),
        ],
        const SizedBox(height: 20),

        _Reveal(animation: _aSubmit, child: _buildSubmit(isRegister, isLoading)),
        const SizedBox(height: 14),

        _Reveal(animation: _aGuest, child: _buildGuest(isLoading)),
      ],
    );
  }

  Widget _buildSubmit(bool isRegister, bool isLoading) {
    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: isLoading ? null : _submit,
        style: FilledButton.styleFrom(
          backgroundColor: _kInk,
          disabledBackgroundColor: _kInk,
          shape: const StadiumBorder(),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isRegister
                        ? Icons.person_add_alt_1_rounded
                        : Icons.login_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isRegister ? 'Daftar' : 'Masuk',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildGuest(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: isLoading
              ? null
              : () {
                  ref.read(authControllerProvider.notifier).continueAsGuest();
                  if (mounted) context.go('/home');
                },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            foregroundColor: _kInk,
            side: const BorderSide(color: _kBorder),
            shape: const StadiumBorder(),
          ),
          icon: const Icon(Icons.person_outline_rounded, size: 20),
          label: const Text(
            'Lanjutkan sebagai Tamu',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Sebagai tamu, kamu hanya bisa membaca materi pembuka '
          'dan progres tidak tersimpan.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, height: 1.4, color: _kTextSecondary),
        ),
      ],
    );
  }

  Widget _buildTerms() {
    const style = TextStyle(fontSize: 13, height: 1.4, color: _kTextSecondary);
    if (widget.onOpenTerms == null) {
      return const Text(
        'Dengan melanjutkan, kamu menyetujui Syarat & Ketentuan',
        textAlign: TextAlign.center,
        style: style,
      );
    }
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text('Dengan melanjutkan, kamu menyetujui ', style: style),
        TextButton(
          onPressed: widget.onOpenTerms,
          style: TextButton.styleFrom(
            foregroundColor: _kInk,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            minimumSize: const Size(48, 48),
            tapTargetSize: MaterialTapTargetSize.padded,
          ),
          child: const Text(
            'Syarat & Ketentuan',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

/// Ilustrasi header — dekoratif, disembunyikan dari screen reader.
class _Header extends StatelessWidget {
  const _Header({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: Image.asset(
          'assets/images/login.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

/// Fade + slide. `dy` positif = naik dari bawah, negatif = turun dari atas.
class _Reveal extends StatelessWidget {
  const _Reveal({required this.animation, required this.child, this.dy = 16});

  final Animation<double> animation;
  final Widget child;
  final double dy;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * dy),
            child: child,
          ),
        );
      },
    );
  }
}

class _Labeled extends StatelessWidget {
  const _Labeled({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kInk,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

/// Field pill: border 3:1 saat diam, Ink 2px saat fokus, merah saat error.
/// Error text ditampilkan DI BAWAH border (bukan di dalam pill).
class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.controller,
    required this.hint,
    this.helperText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final String? helperText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final AutovalidateMode autovalidateMode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;

  static OutlineInputBorder _outline(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      style: const TextStyle(fontSize: 16, color: _kInk),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _kHintGrey, fontSize: 16),
        helperText: helperText,
        helperStyle: const TextStyle(fontSize: 13, color: _kTextSecondary),
        errorStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: _kError,
        ),
        errorMaxLines: 2,
        filled: true,
        fillColor: _kFieldFill,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: _outline(_kBorder, 1.2),
        enabledBorder: _outline(_kBorder, 1.2),
        focusedBorder: _outline(_kInk, 2),
        errorBorder: _outline(_kError, 1.5),
        focusedErrorBorder: _outline(_kError, 2),
        disabledBorder: _outline(_kBorder, 1.2),
      ),
    );
  }
}

/// Error level-form (mis. "email atau kata sandi salah"). Live region supaya
/// screen reader membacakannya saat muncul.
class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kErrorBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kError),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline_rounded, size: 20, color: _kError),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.35,
                  color: _kInk,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Konfirmasi Daftar berhasil — persisten sampai user login / ganti mode.
class _RegisteredNotice extends StatelessWidget {
  const _RegisteredNotice({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kSuccessBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kSuccessIcon),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.mark_email_read_outlined,
              size: 20,
              color: _kSuccessIcon,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Akun dibuat. Kami mengirim email verifikasi ke $email. '
                'Buka email itu (cek juga folder spam), lalu masuk di sini.',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.35,
                  color: _kInk,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Toggle pill Masuk/Daftar — segmen 48dp, thumb bergeser pakai AnimatedAlign.
class _ModeSwitcher extends StatelessWidget {
  const _ModeSwitcher({
    required this.mode,
    required this.isLoading,
    required this.duration,
    required this.onChanged,
  });

  final _AuthMode mode;
  final bool isLoading;
  final Duration duration;
  final ValueChanged<_AuthMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: duration,
            curve: Curves.easeOutCubic,
            alignment: mode == _AuthMode.login
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _kInk,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _ModeSwitcherSegment(
                  label: 'Masuk',
                  selected: mode == _AuthMode.login,
                  duration: duration,
                  onTap: isLoading ? null : () => onChanged(_AuthMode.login),
                ),
              ),
              Expanded(
                child: _ModeSwitcherSegment(
                  label: 'Daftar',
                  selected: mode == _AuthMode.register,
                  duration: duration,
                  onTap: isLoading ? null : () => onChanged(_AuthMode.register),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModeSwitcherSegment extends StatelessWidget {
  const _ModeSwitcherSegment({
    required this.label,
    required this.selected,
    required this.duration,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Duration duration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: duration,
            curve: Curves.easeOut,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : _kInk,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}