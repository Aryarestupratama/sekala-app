import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_state.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/history/presentation/screens/era_list_screen.dart';
import '../../features/history/presentation/screens/era_roadmap_screen.dart';
import '../../features/history/presentation/screens/section_detail_screen.dart';
import '../../features/card/presentation/screens/card_list_screen.dart';
import '../../features/card/presentation/screens/card_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../shared/widgets/main_shell.dart';

/// Jembatan Riverpod -> Listenable, supaya GoRouter otomatis re-evaluate
/// `redirect` setiap kali AuthState berubah (login/logout/guest),
/// tanpa perlu rebuild seluruh GoRouter instance (yang bisa merusak
/// navigation stack).
class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(Ref ref) {
    ref.listen<AuthState>(authNotifierProvider, (_, __) => notifyListeners());
  }
}

/// Path yang wajib login (bukan guest) — R-GUEST-03: guest yang mencoba
/// akses kuis/progress/card diarahkan ke halaman login/registrasi.
/// (Kuis tidak punya route sendiri karena dibuka via WebView dari section,
/// bukan route terpisah — lihat Architecture.md §4.2.)
const _protectedPathPrefixes = ['/cards', '/profile'];

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _AuthRefreshListenable(ref);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final location = state.matchedLocation;
      final isSplash = location == '/splash';
      final isAuth = location == '/auth';

      switch (authState.status) {
        case AuthStatus.checking:
          // Masih cek token tersimpan (Design.md §3.1 poin 1) — tahan di splash.
          return isSplash ? null : '/splash';

        case AuthStatus.unauthenticated:
          // Belum login & belum pilih guest -> wajib ke Auth screen.
          return isAuth ? null : '/auth';

        case AuthStatus.guest:
          if (isSplash) return '/home';
          // Guest BOLEH sengaja balik ke /auth (mis. tap "Masuk untuk
          // melacak progress" di Home) buat login/register beneran —
          // jangan dipaksa balik ke /home, itu bakal mem-blok flow guest
          // yang mau upgrade jadi user login.
          if (isAuth) return null;
          final isProtected = _protectedPathPrefixes
              .any((prefix) => location.startsWith(prefix));
          // R-GUEST-03
          return isProtected ? '/auth' : null;

        case AuthStatus.authenticated:
          if (isSplash || isAuth) return '/home';
          return null;
      }
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),

      // Bottom-nav shell: Home / Informasi Sejarah / Collectible Card / Profil
      // (Design.md §2). Guest tetap lihat 4 tab yang sama; kalau nekat masuk
      // /cards atau /profile, redirect guard di atas yang menendang ke /auth.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const EraListScreen(),
                routes: [
                  GoRoute(
                    path: ':eraSlug',
                    builder: (context, state) => EraRoadmapScreen(
                      eraSlug: state.pathParameters['eraSlug']!,
                    ),
                  ),
                ],
              ),
              // Detail section sengaja di top-level (bukan nested di bawah
              // /history/:eraSlug) supaya bisa di-deep-link langsung dari
              // rekomendasi Home (HOME-02) tanpa harus lewat roadmap dulu.
              GoRoute(
                path: '/section/:sectionId',
                builder: (context, state) => SectionDetailScreen(
                  sectionId: state.pathParameters['sectionId']!,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cards',
                builder: (context, state) => const CardListScreen(),
                routes: [
                  GoRoute(
                    path: ':figureId',
                    builder: (context, state) => CardDetailScreen(
                      figureId: state.pathParameters['figureId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
