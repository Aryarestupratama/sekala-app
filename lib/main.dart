import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import 'core/network/dio_client.dart';
import 'core/router/app_router.dart';
import 'core/router/auth_state.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/tutorial_tour_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SekalaApp()));
}

class SekalaApp extends ConsumerStatefulWidget {
  const SekalaApp({super.key});

  @override
  ConsumerState<SekalaApp> createState() => _SekalaAppState();
}

class _SekalaAppState extends ConsumerState<SekalaApp> {
  @override
  void initState() {
    super.initState();
    // Hubungkan DioClient: setiap kali ada response 401 (token invalid/
    // expired), auto logout & redirect guard di app_router.dart yang
    // otomatis mindahin ke /auth. Token sudah dibersihkan dari secure
    // storage di dalam _onError DioClient, di sini cukup update AuthState.
    DioClient.instance.onUnauthenticated = () {
      ref.read(authNotifierProvider.notifier).logout();
    };

    // Daftarkan ShowcaseView SEKALI untuk seluruh app (API showcaseview
    // >=5.0.0 -- ShowCaseWidget lama sudah deprecated & TIDAK dipakai lagi
    // di sini). Tidak perlu widget wrapper apapun di widget tree; Showcase
    // widget di layar manapun otomatis "nempel" ke registrasi global ini.
    ShowcaseView.register(
      onFinish: () => TutorialTourController.onStepFinished(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'SEKALA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}