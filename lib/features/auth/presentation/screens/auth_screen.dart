import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../providers/auth_providers.dart';

/// Design.md §3.1 + §5.2 — header dengan gambar asli (assets/images/login.png),
/// toggle pill Masuk/Daftar, form minimalis rounded.
///
/// Logic (auth provider, validator, submit flow) tidak berubah.
/// Build method dipecah jadi `_buildFormFields` supaya nesting tidak dalam.
///
/// CATATAN WARNA: kalau project sudah punya `AppColors` di `core/theme/`,
/// ganti `_kInk`/dst di bawah dengan `AppColors.*` biar satu sumber token.
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

enum _AuthMode { login, register }

// Design.md §5.2 — Ink & Sky.
const _kInk = Color(0xFF0C0C0C);
const _kBgLight = Color(0xFFF7F7F8);
const _kFieldFill = Colors.white;
const _kHintGrey = Color(0xFF9CA3AF);
const _kBorderGrey = Color(0xFFE9EAEC);

const _kGoogleBlue = Color(0xFF4285F4);
const _kGoogleGreen = Color(0xFF34A853);
const _kGoogleYellow = Color(0xFFFBBC05);
const _kGoogleRed = Color(0xFFEA4335);

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  _AuthMode _mode = _AuthMode.login;
  bool _obscurePassword = true;

  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    // Entrance sekali di awal buka layar, bukan tiap ganti tab.
    _entrance.forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  /// Interval fade-up per slot komponen, dari atas ke bawah.
  Animation<double> _slot(double begin, double end) {
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(authControllerProvider.notifier);
    if (_mode == _AuthMode.login) {
      await controller.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Redirect ke /home ditangani guard di app_router.dart.
    } else {
      final success = await controller.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmController.text,
      );
      // Register TIDAK auto-login (R-AUTH-02/03): tampilkan konfirmasi
      // dan alihkan balik ke mode Login.
      if (success && mounted) {
        _clearFormForLogin();
        _showSuccess(
          'Registrasi berhasil! Silakan cek email untuk verifikasi, '
          'lalu login di sini.',
        );
      }
    }
  }

  void _clearFormForLogin() {
    setState(() {
      _mode = _AuthMode.login;
      _nameController.clear();
      _passwordController.clear();
      _passwordConfirmController.clear();
      // Email sengaja dibiarkan terisi.
    });
  }

  // Login Google DINONAKTIFKAN sementara — backend belum punya endpoint
  // stateless untuk mobile (POST /auth/google dengan id_token).
  // Uncomment + tambah `google_sign_in` kalau backend sudah siap:
  //
  // Future<void> _submitGoogle() async {
  //   try {
  //     final account = await _googleSignIn.signIn();
  //     if (account == null) return;
  //     final auth = await account.authentication;
  //     final idToken = auth.idToken;
  //     if (idToken == null) {
  //       _showError('Gagal mendapatkan token dari Google. Coba lagi.');
  //       return;
  //     }
  //     await ref
  //         .read(authControllerProvider.notifier)
  //         .loginWithGoogle(idToken: idToken);
  //   } catch (_) {
  //     _showError('Login dengan Google gagal. Coba lagi.');
  //   }
  // }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 5),
        ),
      );
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
      return error.validationErrors!.values.first.first;
    }
    return error.message;
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authControllerState = ref.watch(authControllerProvider);
    final isLoading = authControllerState.isLoading;
    final isRegister = _mode == _AuthMode.register;

    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          final message = error is ApiException
              ? _formatApiError(error)
              : 'Terjadi kesalahan. Silakan coba lagi.';
          _showError(message);
        },
      );
    });

    return Scaffold(
      backgroundColor: _kBgLight,
      body: SafeArea(
        child: Column(
          children: [
            // Konten utama tidak bisa discroll; FittedBox(scaleDown)
            // mengecilkan konten kalau mode Daftar lebih tinggi dari layar.
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _FadeSlideDown(
                          animation: _slot(0.0, 0.45),
                          child: const _Header(),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 18, 24, 16),
                          child: Form(
                            key: _formKey,
                            child: _buildFormFields(isRegister, isLoading),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Teks syarat paten di bawah layar, di luar area FittedBox.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: _FadeSlideUp(
                animation: _slot(0.52, 0.96),
                child: Text(
                  'Dengan melanjutkan, kamu menyetujui Syarat & Ketentuan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(bool isRegister, bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FadeSlideUp(
          animation: _slot(0.10, 0.55),
          child: _ModeSwitcher(
            mode: _mode,
            isLoading: isLoading,
            onChanged: (mode) => setState(() => _mode = mode),
          ),
        ),
        const SizedBox(height: 18),

        // Nama (hanya mode Daftar)
        _FadeSlideUp(
          animation: _slot(0.18, 0.62),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            child: isRegister
                ? Column(
                    key: const ValueKey('name-field'),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _fieldLabel('Nama'),
                      _PillTextField(
                        controller: _nameController,
                        hint: 'Nama lengkap kamu',
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                                ? 'Nama wajib diisi'
                                : null,
                      ),
                      const SizedBox(height: 14),
                    ],
                  )
                : const SizedBox(key: ValueKey('name-field-empty')),
          ),
        ),

        // Email
        _FadeSlideUp(
          animation: _slot(0.22, 0.66),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _fieldLabel('Email'),
              _PillTextField(
                controller: _emailController,
                hint: 'nama@email.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validateEmail,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Kata sandi
        _FadeSlideUp(
          animation: _slot(0.26, 0.70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _fieldLabel('Kata Sandi'),
              _PillTextField(
                controller: _passwordController,
                hint: '••••••••',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                    color: Colors.black54,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                textInputAction:
                    isRegister ? TextInputAction.next : TextInputAction.done,
                onFieldSubmitted: !isRegister ? (_) => _submit() : null,
                validator: _validatePassword,
              ),
            ],
          ),
        ),

        // Konfirmasi kata sandi (hanya mode Daftar)
        _FadeSlideUp(
          animation: _slot(0.30, 0.74),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            child: isRegister
                ? Column(
                    key: const ValueKey('confirm-field'),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 14),
                      _fieldLabel('Konfirmasi Kata Sandi'),
                      _PillTextField(
                        controller: _passwordConfirmController,
                        hint: '••••••••',
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Konfirmasi kata sandi tidak cocok';
                          }
                          return null;
                        },
                      ),
                    ],
                  )
                : const SizedBox(key: ValueKey('confirm-field-empty')),
          ),
        ),

        // Lupa kata sandi (hanya mode Masuk)
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOutCubic,
          alignment: Alignment.topCenter,
          child: !isRegister
              ? Padding(
                  key: const ValueKey('forgot-password'),
                  padding: const EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: isLoading
                          ? null
                          : () => _showError(
                              'Fitur lupa kata sandi belum tersedia.'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Lupa kata sandi?',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ),
                  ),
                )
              : const SizedBox(key: ValueKey('forgot-empty')),
        ),
        const SizedBox(height: 18),

        // Tombol Masuk / Daftar
        _FadeSlideUp(
          animation: _slot(0.36, 0.80),
          child: SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: isLoading ? null : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: _kInk,
                shape: const StadiumBorder(),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
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
                          size: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isRegister ? 'Daftar' : 'Masuk',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Divider "atau"
        _FadeSlideUp(
          animation: _slot(0.40, 0.84),
          child: Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'atau',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Tombol Google
        _FadeSlideUp(
          animation: _slot(0.44, 0.88),
          child: SizedBox(
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () => _showError(
                'Login Google belum tersedia untuk mobile. '
                'Gunakan email & kata sandi dulu.',
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey.shade300),
                shape: const StadiumBorder(),
              ),
              icon: const SizedBox(
                height: 18,
                width: 18,
                child: CustomPaint(painter: _GoogleGPainter()),
              ),
              label: const Text(
                'Google',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Tombol Tamu
        _FadeSlideUp(
          animation: _slot(0.48, 0.92),
          child: Center(
            child: _GuestButton(
              isLoading: isLoading,
              onTap: () {
                ref.read(authControllerProvider.notifier).continueAsGuest();
                if (context.mounted) context.go('/home');
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Header dengan gambar dari assets/images/login.png, tinggi dibatasi
/// supaya form (terutama mode Daftar) tetap muat.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 190),
      child: Image.asset(
        'assets/images/login.png',
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}

/// Fade + slide dari bawah ke posisi normal.
class _FadeSlideUp extends StatelessWidget {
  const _FadeSlideUp({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * 18),
            child: child,
          ),
        );
      },
    );
  }
}

/// Fade + slide dari atas turun ke bawah — khusus ilustrasi header.
class _FadeSlideDown extends StatelessWidget {
  const _FadeSlideDown({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * -32),
            child: child,
          ),
        );
      },
    );
  }
}

/// Pill text field ramping — border tipis, berubah jadi shadow lembut saat fokus.
class _PillTextField extends StatefulWidget {
  const _PillTextField({
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  State<_PillTextField> createState() => _PillTextFieldState();
}

class _PillTextFieldState extends State<_PillTextField> {
  final _focusNode = FocusNode();
  bool _focused = false;

  void _onFocusChange() {
    if (!mounted) return;
    setState(() => _focused = _focusNode.hasFocus);
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: _kFieldFill,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: _focused ? _kInk.withValues(alpha: 0.12) : _kBorderGrey,
          width: 1.2,
        ),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.08),
                  blurRadius: 18,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                ),
              ]
            : const [],
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        style: const TextStyle(fontSize: 14.5),
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hint,
          hintStyle: const TextStyle(color: _kHintGrey, fontSize: 14),
          filled: false,
          suffixIcon: widget.suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

/// Toggle pill hitam/putih Masuk-Daftar — thumb bergeser pakai AnimatedAlign.
class _ModeSwitcher extends StatelessWidget {
  const _ModeSwitcher({
    required this.mode,
    required this.isLoading,
    required this.onChanged,
  });

  final _AuthMode mode;
  final bool isLoading;
  final ValueChanged<_AuthMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: _kBorderGrey),
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 260),
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
                  borderRadius: BorderRadius.circular(19),
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
                  onTap: isLoading ? null : () => onChanged(_AuthMode.login),
                ),
              ),
              Expanded(
                child: _ModeSwitcherSegment(
                  label: 'Daftar',
                  selected: mode == _AuthMode.register,
                  onTap:
                      isLoading ? null : () => onChanged(_AuthMode.register),
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
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

/// Tombol "Lanjutkan sebagai Tamu" — pill outline tipis + ikon.
class _GuestButton extends StatelessWidget {
  const _GuestButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: isLoading ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _kBorderGrey),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 17,
                color: Colors.black87,
              ),
              SizedBox(width: 6),
              Text(
                'Lanjutkan sebagai Tamu',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Logo "G" Google 4-warna, digambar manual supaya self-contained.
class _GoogleGPainter extends CustomPainter {
  const _GoogleGPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = size.width * 0.22;
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    Paint ring(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    const gapDeg = 4.0;
    double rad(double deg) => deg * math.pi / 180;

    // Ring penuh kecuali bukaan ~40° di sisi kanan (tempat palang biru).
    canvas.drawArc(rect, rad(20 + gapDeg / 2), rad(80 - gapDeg), false,
        ring(_kGoogleGreen));
    canvas.drawArc(rect, rad(100 + gapDeg / 2), rad(80 - gapDeg), false,
        ring(_kGoogleYellow));
    canvas.drawArc(rect, rad(180 + gapDeg / 2), rad(80 - gapDeg), false,
        ring(_kGoogleRed));
    canvas.drawArc(rect, rad(260 + gapDeg / 2), rad(80 - gapDeg), false,
        ring(_kGoogleBlue));

    // Palang biru horizontal yang mengisi bukaan kanan.
    final barPaint = Paint()..color = _kGoogleBlue;
    final barRect = Rect.fromLTWH(
      center.dx - strokeWidth * 0.15,
      center.dy - strokeWidth / 2,
      radius - center.dx + strokeWidth * 0.15 + size.width * 0.06,
      strokeWidth,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(barRect, Radius.circular(strokeWidth * 0.25)),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}