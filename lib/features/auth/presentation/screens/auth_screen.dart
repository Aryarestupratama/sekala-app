import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../shared/widgets/wave_clipper.dart';
import '../providers/auth_providers.dart';

/// Design.md §3.1 + §5.2 — header biru (Sky) dengan wave di bawah, judul
/// SEKALA, toggle pill Masuk/Daftar, form minimalis rounded.
///
/// CATATAN WARNA: dipakai hex langsung sesuai Design.md §5.2 (Ink, Sky).
/// Kalau project sudah punya `AppColors` di `core/theme/`, ganti
/// `_kInk`/`_kSky`/dst di bawah dengan `AppColors.ink`/`AppColors.sky`
/// biar konsisten satu sumber token di seluruh app.
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

enum _AuthMode { login, register }

// Design.md §5.2 — Ink & Sky. Ganti ke AppColors kalau sudah tersedia.
const _kInk = Color(0xFF0C0C0C);
const _kSky = Color(0xFF77DDFA);
const _kBgLight = Color(0xFFF7F7F8);
const _kFieldFill = Colors.white;
const _kHintGrey = Color(0xFF9CA3AF);

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  _AuthMode _mode = _AuthMode.login;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(authControllerProvider.notifier);
    if (_mode == _AuthMode.login) {
      await controller.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Redirect ke /home ditangani otomatis oleh guard di app_router.dart
      // begitu authNotifierProvider berubah jadi authenticated.
    } else {
      final success = await controller.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmController.text,
      );
      // Register TIDAK auto-login (user belum email_verified —
      // R-AUTH-02/03). Tampilkan konfirmasi & alihkan balik ke mode
      // Login supaya user submit credentials lagi setelah verifikasi.
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
      // Email sengaja dibiarkan terisi supaya user tinggal isi password.
    });
  }

  // Login Google DINONAKTIFKAN sementara — backend cuma punya
  // redirect-based OAuth (GET auth/google/redirect + callback, didesain
  // buat browser), belum ada endpoint stateless yang cocok buat mobile
  // (biasanya POST /auth/google nerima id_token dari google_sign_in).
  // Tinggal uncomment + tambah `google_sign_in` ke import kalau backend
  // sudah siap:
  //
  // Future<void> _submitGoogle() async {
  //   try {
  //     final account = await _googleSignIn.signIn();
  //     if (account == null) return; // user batal
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
      final firstError = error.validationErrors!.values.first.first;
      return firstError;
    }
    return error.message;
  }

  InputDecoration _fieldDecoration({
    required String hint,
    Widget? suffixIcon,
  }) {
    final radius = BorderRadius.circular(16);
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _kHintGrey),
      filled: true,
      fillColor: _kFieldFill,
      suffixIcon: suffixIcon,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: _kInk, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Header(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ModeSwitcher(
                      mode: _mode,
                      isLoading: isLoading,
                      onChanged: (mode) => setState(() => _mode = mode),
                    ),
                    const SizedBox(height: 28),
                    if (isRegister) ...[
                      _fieldLabel('Nama'),
                      TextFormField(
                        controller: _nameController,
                        decoration:
                            _fieldDecoration(hint: 'Nama lengkap kamu'),
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                                ? 'Nama wajib diisi'
                                : null,
                      ),
                      const SizedBox(height: 20),
                    ],
                    _fieldLabel('Email'),
                    TextFormField(
                      controller: _emailController,
                      decoration: _fieldDecoration(hint: 'nama@email.com'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 20),
                    _fieldLabel('Kata Sandi'),
                    TextFormField(
                      controller: _passwordController,
                      decoration: _fieldDecoration(
                        hint: '••••••••',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black54,
                          ),
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      obscureText: _obscurePassword,
                      textInputAction: isRegister
                          ? TextInputAction.next
                          : TextInputAction.done,
                      onFieldSubmitted:
                          !isRegister ? (_) => _submit() : null,
                      validator: _validatePassword,
                    ),
                    if (isRegister) ...[
                      const SizedBox(height: 20),
                      _fieldLabel('Konfirmasi Kata Sandi'),
                      TextFormField(
                        controller: _passwordConfirmController,
                        decoration: _fieldDecoration(hint: '••••••••'),
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
                    if (!isRegister) ...[
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: isLoading
                              ? null
                              : () => _showError(
                                  'Fitur lupa kata sandi belum tersedia.'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Lupa kata sandi?',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: isLoading ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: _kInk,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
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
                            : Text(
                                isRegister ? 'Daftar' : 'Masuk',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'atau',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                        Expanded(
                            child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () => _showError(
                          'Login Google belum tersedia untuk mobile. '
                          'Gunakan email & kata sandi dulu.',
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        icon: const Text(
                          'G',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4285F4),
                          ),
                        ),
                        label: const Text(
                          'Lanjutkan dengan Google',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .continueAsGuest();
                                if (context.mounted) context.go('/home');
                              },
                        child: const Text(
                          'Lanjutkan sebagai Tamu',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Dengan melanjutkan, kamu menyetujui Syarat & Ketentuan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Header biru (Sky) dengan wave di bawah — masih background polos untuk
/// sekarang. Nanti tinggal tambah `Image`/ilustrasi di dalam Stack ini
/// (mis. gambar tenaga medis/sejarah) tanpa perlu ubah wave-nya.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const WaveClipper(),
      child: Container(
        width: double.infinity,
        height: 300,
        color: _kSky,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SEKALA',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: _kInk,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Jelajahi sejarah kesehatan Indonesia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Toggle pill hitam/putih Masuk-Daftar — pengganti SegmentedButton bawaan
/// Material supaya persis desain (pill besar, thumb hitam solid).
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
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? _kInk : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}