import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/auth/presentation/providers/auth_providers.dart';

// Token kontras (selaras dengan auth_screen.dart): border field 3:1 terhadap
// putih, hint 4.5:1, merah error 6.5:1.
const Color _kBorder = Color(0xFF8A8A8A);
const Color _kHint = Color(0xFF6B7280);
const Color _kError = Color(0xFFB3261D);
const Color _kErrorBg = Color(0xFFFDECEA);

/// Form ganti kata sandi. Dibuka dari ProfileScreen ("Ubah Kata Sandi").
///
/// REVISI (design review) — `_submit()`, validator, dan pemakaian
/// `changePasswordControllerProvider` TIDAK berubah. Yang berubah:
/// - Input memakai `OutlineInputBorder` (error tampil DI BAWAH field, bukan
///   di dalam pill), border 3:1, fokus Ink 2dp, teks 16sp (dulu 14.5 dengan
///   border 1.2:1 dan hint "••••••••" yang tampak seperti sudah terisi).
/// - Autofill (password manager) + keyboard action (next/done).
/// - Istilah seragam "kata sandi" (dulu campur "Password"/"Kata Sandi").
/// - Kotak error: teks Ink + ikon merah (merah di atas tint merah ~3.5:1).
/// - Tombol visibilitas diberi tooltip.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _autoValidate = false;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidate = true);
      return;
    }

    final ok =
        await ref.read(changePasswordControllerProvider.notifier).submit(
              currentPassword: _currentCtrl.text,
              newPassword: _newCtrl.text,
              newPasswordConfirmation: _confirmCtrl.text,
            );

    if (!mounted) return;

    if (ok) {
      TextInput.finishAutofillContext();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kata sandi berhasil diubah.')),
      );
      Navigator.of(context).pop();
    }
  }

  static OutlineInputBorder _outline(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback toggleObscure,
    required String? Function(String?) validator,
    required Iterable<String> autofillHints,
    required TextInputAction action,
    String? helperText,
    VoidCallback? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 6),
          child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          autovalidateMode:
              _autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
          autofillHints: autofillHints,
          textInputAction: action,
          onFieldSubmitted: onSubmitted == null ? null : (_) => onSubmitted(),
          style: const TextStyle(fontSize: 16, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: _kHint, fontSize: 16),
            helperText: helperText,
            helperStyle: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            errorStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _kError),
            errorMaxLines: 2,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: _outline(_kBorder, 1.2),
            enabledBorder: _outline(_kBorder, 1.2),
            focusedBorder: _outline(AppColors.ink, 2),
            errorBorder: _outline(_kError, 1.5),
            focusedErrorBorder: _outline(_kError, 2),
            suffixIcon: IconButton(
              tooltip: obscure ? 'Tampilkan kata sandi' : 'Sembunyikan kata sandi',
              icon: Icon(
                obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 22,
                color: AppColors.textSecondary,
              ),
              onPressed: toggleObscure,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordControllerProvider);
    final isLoading = state.isLoading;

    // CATATAN: saya asumsikan ApiException punya getter `.message`.
    // Kalau nama getter berbeda di project kamu, sesuaikan baris ini saja.
    final errorMessage = state.hasError && state.error is ApiException
        ? (state.error as ApiException).message
        : (state.hasError ? 'Kata sandi belum bisa diubah. Coba lagi.' : null);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Ubah Kata Sandi', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Form(
        key: _formKey,
        child: AutofillGroup(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            children: [
              if (errorMessage != null) ...[
                Semantics(
                  liveRegion: true,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _kErrorBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _kError),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.error_outline_rounded, size: 20, color: _kError),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(fontSize: 14, height: 1.35, color: AppColors.ink),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
              _field(
                controller: _currentCtrl,
                label: 'Kata sandi saat ini',
                hint: 'Masukkan kata sandi saat ini',
                obscure: _obscureCurrent,
                toggleObscure: () => setState(() => _obscureCurrent = !_obscureCurrent),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                autofillHints: const [AutofillHints.password],
                action: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              _field(
                controller: _newCtrl,
                label: 'Kata sandi baru',
                hint: 'Masukkan kata sandi baru',
                helperText: 'Minimal 8 karakter',
                obscure: _obscureNew,
                toggleObscure: () => setState(() => _obscureNew = !_obscureNew),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Wajib diisi';
                  if (v.length < 8) return 'Minimal 8 karakter';
                  return null;
                },
                autofillHints: const [AutofillHints.newPassword],
                action: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              _field(
                controller: _confirmCtrl,
                label: 'Konfirmasi kata sandi baru',
                hint: 'Ulangi kata sandi baru',
                obscure: _obscureConfirm,
                toggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm),
                validator: (v) {
                  if (v != _newCtrl.text) return 'Konfirmasi tidak cocok';
                  return null;
                },
                autofillHints: const [AutofillHints.newPassword],
                action: TextInputAction.done,
                onSubmitted: isLoading ? null : _submit,
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: isLoading ? null : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    disabledBackgroundColor: AppColors.ink,
                    shape: const StadiumBorder(),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Simpan', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}