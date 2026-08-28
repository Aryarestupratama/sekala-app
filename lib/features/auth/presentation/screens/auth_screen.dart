import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../providers/auth_providers.dart';

/// Design.md §3.1: [Login] [Daftar] [Lanjutkan dengan Google] [Lanjutkan
/// sebagai Guest], digabung jadi satu screen dengan toggle Login/Daftar.
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

enum _AuthMode { login, register }

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
    } else {
      await controller.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmController.text,
      );
    }
    // Redirect ke /home ditangani otomatis oleh guard di app_router.dart
    // begitu authNotifierProvider berubah jadi authenticated. Kalau gagal,
    // errornya ditangkap oleh ref.listen di build() lewat authControllerProvider.
  }

  // Login Google DINONAKTIFKAN sementara — lihat komentar di tombolnya
  // pada build(). Method ini disimpan (di-comment) supaya gampang
  // diaktifkan lagi begitu backend nyediain endpoint yang cocok buat
  // mobile (mis. POST /auth/google nerima id_token), tinggal uncomment
  // + tambah `google_sign_in` ke import + field `_googleSignIn` lagi:
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

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email wajib diisi';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Format email tidak valid';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password wajib diisi';
    if (_mode == _AuthMode.register && value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    return null;
  }

  String _formatApiError(ApiException error) {
    if (error.isValidationError) {
      // Ambil pesan pertama dari error validasi Laravel (422), biar nggak
      // numpuk semua di satu SnackBar.
      final firstError = error.validationErrors!.values.first.first;
      return firstError;
    }
    return error.message;
  }

  @override
  Widget build(BuildContext context) {
    final authControllerState = ref.watch(authControllerProvider);
    final isLoading = authControllerState.isLoading;

    // Tampilkan error dari AuthController (login/register/google gagal)
    // sebagai SnackBar, termasuk pesan validasi spesifik per-field dari
    // Laravel (422) kalau ada.
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
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'SEKALA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sejarah & Edukasi Kesehatan Alur Lintas Abad',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SegmentedButton<_AuthMode>(
                  segments: const [
                    ButtonSegment(value: _AuthMode.login, label: Text('Login')),
                    ButtonSegment(
                        value: _AuthMode.register, label: Text('Daftar')),
                  ],
                  selected: {_mode},
                  onSelectionChanged: isLoading
                      ? null
                      : (selection) => setState(() => _mode = selection.first),
                ),
                const SizedBox(height: 24),
                if (_mode == _AuthMode.register) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    textInputAction: TextInputAction.next,
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Nama wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  obscureText: _obscurePassword,
                  textInputAction: _mode == _AuthMode.register
                      ? TextInputAction.next
                      : TextInputAction.done,
                  onFieldSubmitted:
                      _mode == _AuthMode.login ? (_) => _submit() : null,
                  validator: _validatePassword,
                ),
                if (_mode == _AuthMode.register) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordConfirmController,
                    decoration:
                        const InputDecoration(labelText: 'Konfirmasi Password'),
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Konfirmasi password tidak cocok';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(_mode == _AuthMode.login ? 'Login' : 'Daftar'),
                ),
                const SizedBox(height: 12),
                // Dinonaktifkan sementara: backend cuma punya redirect-based
                // OAuth (GET auth/google/redirect + callback, didesain buat
                // browser), belum ada endpoint stateless yang cocok buat
                // mobile (biasanya POST /auth/google nerima id_token dari
                // google_sign_in). Nunggu keputusan pendekatan backend
                // sebelum tombol ini diaktifin lagi — lihat AuthController.
                OutlinedButton.icon(
                  onPressed: () => _showError(
                    'Login Google belum tersedia untuk mobile. '
                    'Gunakan email & password dulu.',
                  ),
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Lanjutkan dengan Google'),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          ref.read(authControllerProvider.notifier).continueAsGuest();
                          if (context.mounted) context.go('/home');
                        },
                  child: const Text('Lanjutkan sebagai Guest'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
