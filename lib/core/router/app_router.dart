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
import '../../features/year_summary/presentation/screens/year_summary_screen.dart';
import '../../features/quiz/presentation/screens/quiz_screen.dart';
import '../../features/era_quiz/presentation/screens/era_quiz_screen.dart';
import '../../features/era_quiz/presentation/screens/era_quiz_result_screen.dart';
import '../../features/era_quiz/presentation/screens/era_quiz_recap_screen.dart';
import '../../features/card/presentation/screens/vaccine_list_screen.dart';
import '../../features/card/presentation/screens/vaccine_detail_screen.dart';
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

/// Path (prefix) yang wajib login (bukan guest) — R-GUEST-03: guest yang
/// mencoba akses kuis/progress/card diarahkan ke halaman login/registrasi.
const _protectedPathPrefixes = ['/cards', '/profile'];

/// Halaman Rangkuman Wabah (`/year/:yearId/summary`) SENGAJA TIDAK masuk
/// daftar protected di atas — secara alami cuma terjangkau lewat CTA
/// "Lihat Rangkuman" yang cuma muncul kalau section sudah completed, dan
/// `completed` selalu false untuk guest (R-PROG-06, tidak ada
/// user_progress tersimpan) — jadi guest praktis tidak akan pernah
/// sampai ke sini lewat flow normal. Kuis (`/year/:yearId/quiz` DAN
/// `/era-quiz/:eraId`) beda: R-QUIZ-09/R-ERAQUIZ-03 melarang guest akses
/// kuis SAMA SEKALI (baik kuis year maupun kuis sumatif era), jadi tetap
/// dijaga eksplisit di `redirect` di bawah (bukan cuma implisit dari flow
/// UI), buat jaga-jaga kalau ada deep link langsung ke path ini.
///
/// PERBAIKAN: sebelumnya fungsi ini cuma cek `contains('/quiz')`, yang
/// TIDAK match `/era-quiz/3` (substring-nya `-quiz`, bukan `/quiz` —
/// diawali `-` bukan `/`) — akibatnya kuis sumatif era LOLOS dari guard
/// guest ini. Ditambahkan pengecekan eksplisit prefix `/era-quiz` di
/// samping `/quiz` supaya dua-duanya konsisten terlindungi.
bool _isQuizPath(String location) =>
    location.contains('/quiz') || location.startsWith('/era-quiz');

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
                  .any((prefix) => location.startsWith(prefix)) ||
              _isQuizPath(location); // R-QUIZ-09
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
      // /cards, /profile, atau kuis, redirect guard di atas yang menendang
      // ke /auth.
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
              // BARU — Rangkuman Wabah & Kuis (INFO-04/05, Design.md §3.3
              // poin 4-5). Juga top-level (bukan nested di bawah
              // /history/:eraSlug) dengan alasan sama seperti /section di
              // atas: bisa di-deep-link tanpa lewat roadmap dulu. `eraSlug`
              // dioper lewat query param `?era=` oleh pemanggil
              // (SectionDetailScreen / YearSummaryScreen) karena dibutuhkan
              // buat styling aksen era & invalidate cache roadmap yang
              // tepat setelah submit kuis (lihat quiz_providers.dart).
              GoRoute(
                path: '/year/:yearId/summary',
                builder: (context, state) => YearSummaryScreen(
                  yearId: int.parse(state.pathParameters['yearId']!),
                  eraSlug: state.uri.queryParameters['era'] ?? '',
                ),
              ),
              GoRoute(
                path: '/year/:yearId/quiz',
                builder: (context, state) => QuizScreen(
                  yearId: int.parse(state.pathParameters['yearId']!),
                  eraSlug: state.uri.queryParameters['era'] ?? '',
                  yearTitle: state.uri.queryParameters['title'],
                ),
              ),
              // BARU — Kuis Sumatif Era "final boss" (ERAQUIZ-01/02).
              // Top-level juga (bukan nested di bawah /history/:eraSlug)
              // sama alasannya dengan /year & /section di atas: bisa
              // di-deep-link/di-push langsung dari node final-boss di
              // roadmap tanpa perlu tahu path induknya. `eraId` di sini
              // INTEGER (era_id Eloquent, DIKONFIRMASI ke `Era.php` yang
              // tidak override `getRouteKeyName()`) — BEDA dari
              // `:eraSlug` yang dipakai route /history di atas untuk
              // roadmap publik. Jangan disamakan / tertukar keduanya.
              GoRoute(
                path: '/era-quiz/:eraId',
                builder: (context, state) => EraQuizScreen(
                  eraId: int.parse(state.pathParameters['eraId']!),
                ),
              ),
              // TODO — SEMENTARA: ganti builder ini begitu layar Hasil
              // sungguhan selesai (backlog berikutnya setelah layar
              // Kerjakan Kuis). Lihat komentar di
              // era_quiz_result_placeholder_screen.dart.
              GoRoute(
                path: '/era-quiz/:eraId/result',
                builder: (context, state) => EraQuizResultScreen(
                  eraId: int.parse(state.pathParameters['eraId']!),
                ),
              ),
              GoRoute(
                path: '/era-quiz/:eraId/recap',
                builder: (context, state) => EraQuizRecapScreen(
                  eraId: int.parse(state.pathParameters['eraId']!),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cards',
                builder: (context, state) => const VaccineListScreen(),
                routes: [
                  GoRoute(
                    path: ':vaccineId',
                    builder: (context, state) => VaccineDetailScreen(
                      vaccineId: state.pathParameters['vaccineId']!,
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