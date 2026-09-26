import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sekala_app/shared/provider/active_tab_provider.dart';
import 'package:sekala_app/core/router/auth_state.dart';
import 'package:sekala_app/core/theme/app_colors.dart';
import 'package:sekala_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:sekala_app/features/card/presentation/providers/card_providers.dart';
import 'package:sekala_app/features/badge/presentation/providers/badge_providers.dart';

/// Bottom nav 4 tab: Home / Informasi / Koleksi / Profil (Design.md §2).
/// Dipakai sama untuk user login & guest — guard di app_router.dart yang
/// mengarahkan guest ke /auth saat tap Koleksi/Profil (R-GUEST-03).
///
/// REDESIGN: nav bar "floating pill" (melayang, rounded, shadow lembut).
/// - Lingkaran hitam **meluncur** dari tab lama ke tab baru (easeOutBack,
///   sedikit memantul), ikon aktif jadi putih di atasnya.
/// - Ikon aktif membesar halus, warna ikon & label berubah smooth.
/// - Badge coral di tab Koleksi berdenyut (pulse) saat ada vaksin unseen.
/// - Badge coral di tab Profil berdenyut (pulse) saat ada badge (Studi
///   Kasus) baru yang belum dilihat — sumber sama dengan dot menu
///   "Koleksi Badge" di ProfileScreen (badgeListProvider.meta.unseen).
/// - Bar masuk dengan slide-up + fade saat pertama tampil.
/// - Haptic ringan tiap ganti tab.
///
/// Logic (auth, unseen vaksin/badge, sinkron activeTabIndexProvider,
/// goBranch) TIDAK berubah dari sebelumnya (murni visual), KECUALI
/// `_BottomNavBar.badgeIndex` (tunggal) diganti `badgeIndices` (Set) supaya
/// 2 tab (Koleksi & Profil) bisa sama-sama menyalakan dot secara independen.
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    _NavItemData(
        icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    _NavItemData(
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book_rounded,
        label: 'Informasi'),
    _NavItemData(
        icon: Icons.style_outlined,
        activeIcon: Icons.style_rounded,
        label: 'Koleksi'),
    _NavItemData(
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Profil'),
  ];

  // Index tab tetap (Design.md §2) — dipakai di sini & dibandingkan dengan
  // `koleksiTabIndex` dari active_tab_provider.dart. Tidak ada
  // `profilTabIndex` terpisah di active_tab_provider.dart karena tab
  // Profil tidak butuh gating reveal-queue seperti tab Koleksi (lihat
  // vaccine_list_screen.dart) — dot-nya cukup dihitung dari provider,
  // tanpa perlu tahu "sedang aktif di tab ini atau tidak".
  static const int _profilTabIndex = 3;

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  @override
  void initState() {
    super.initState();
    _syncActiveTab();
  }

  @override
  void didUpdateWidget(covariant MainShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncActiveTab();
  }

  /// Update `activeTabIndexProvider` di luar fase build (post-frame) supaya
  /// tidak melanggar aturan Riverpod. Dipanggil hanya saat shell dibuat /
  /// diperbarui, bukan tiap rebuild. Lihat active_tab_provider.dart.
  void _syncActiveTab() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final tabNotifier = ref.read(activeTabIndexProvider.notifier);
      final current = widget.navigationShell.currentIndex;
      if (tabNotifier.state != current) {
        tabNotifier.state = current;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isVerifiedUser = authState.status == AuthStatus.authenticated;

    // Badge tab Koleksi & Profil hanya untuk user login terverifikasi
    // (guest tidak memicu request /cards atau /badges yang bakal 401/403,
    // R-GUEST-02).
    final unseenVaccines = isVerifiedUser
        ? ref.watch(cardListProvider).valueOrNull?.meta.unseen ?? 0
        : 0;
    final unseenBadges = isVerifiedUser
        ? ref.watch(badgeListProvider).valueOrNull?.meta.unseen ?? 0
        : 0;

    final badgeIndices = <int>{
      if (unseenVaccines > 0) koleksiTabIndex,
      if (unseenBadges > 0) MainShell._profilTabIndex,
    };

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: widget.navigationShell.currentIndex,
        items: MainShell._items,
        badgeIndices: badgeIndices,
        onDestinationSelected: (index) {
          if (index != widget.navigationShell.currentIndex) {
            HapticFeedback.selectionClick();
          }
          widget.navigationShell.goBranch(
            index,
            // Balik ke root tab kalau tab yang sama di-tap lagi.
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const _kInk = Color(0xFF0C0C0C);
const _kInactive = Color(0xFF8A8F98);

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.selectedIndex,
    required this.items,
    required this.onDestinationSelected,
    this.badgeIndices = const {},
  });

  final int selectedIndex;
  final List<_NavItemData> items;
  final ValueChanged<int> onDestinationSelected;

  /// Index item yang perlu badge dot (mis. Koleksi saat ada vaksin unseen,
  /// Profil saat ada badge baru). Diganti dari `int? badgeIndex` tunggal
  /// jadi Set supaya lebih dari satu tab bisa menyala bersamaan, independen
  /// satu sama lain.
  final Set<int> badgeIndices;

  static const double _barHeight = 74;
  static const double _bubbleSize = 44;
  static const double _bubbleTop = 8;
  static const double _hPad = 6;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (context, t, child) {
          return Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(0, (1 - t) * 40),
              child: child,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Container(
            height: _barHeight,
            padding: const EdgeInsets.symmetric(horizontal: _hPad),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0x0F000000)),
              boxShadow: [
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.10),
                  blurRadius: 28,
                  spreadRadius: 0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / items.length;

                return Stack(
                  children: [
                    // Lingkaran hitam yang meluncur ke tab aktif.
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 380),
                      curve: Curves.easeOutBack,
                      left: itemWidth * selectedIndex +
                          (itemWidth - _bubbleSize) / 2,
                      top: _bubbleTop,
                      child: Container(
                        width: _bubbleSize,
                        height: _bubbleSize,
                        decoration: BoxDecoration(
                          color: _kInk,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _kInk.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(items.length, (index) {
                        return Expanded(
                          child: _NavItem(
                            data: items[index],
                            isActive: index == selectedIndex,
                            showBadge: badgeIndices.contains(index),
                            onTap: () => onDestinationSelected(index),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.data,
    required this.isActive,
    required this.onTap,
    this.showBadge = false,
  });

  final _NavItemData data;
  final bool isActive;
  final VoidCallback onTap;
  final bool showBadge;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isActive;
    final iconColor = isActive ? Colors.white : _kInactive;
    final labelColor = isActive
        ? _kInk
        : (_isHovered ? _kInk.withValues(alpha: 0.6) : _kInactive);

    return Semantics(
      button: true,
      selected: isActive,
      label: widget.data.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(top: _BottomNavBar._bubbleTop),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: _BottomNavBar._bubbleSize,
                  height: _BottomNavBar._bubbleSize,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      AnimatedScale(
                        scale: isActive ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOutBack,
                        child: TweenAnimationBuilder<Color?>(
                          tween: ColorTween(end: iconColor),
                          duration: const Duration(milliseconds: 220),
                          builder: (context, color, _) {
                            return Icon(
                              isActive
                                  ? widget.data.activeIcon
                                  : widget.data.icon,
                              color: color,
                              size: 23,
                            );
                          },
                        ),
                      ),
                      if (widget.showBadge)
                        const Positioned(
                          top: 6,
                          right: 6,
                          child: _PulsingDot(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: labelColor,
                    letterSpacing: 0.1,
                  ),
                  child: Text(widget.data.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Dot coral dengan cincin yang berdenyut pelan, menarik perhatian ke tab
/// Koleksi/Profil tanpa terasa mengganggu.
class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = Curves.easeOut.transform(_controller.value);
          return Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: (1 - t) * 0.5,
                child: Container(
                  width: 8 + 6 * t,
                  height: 8 + 6 * t,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.coral,
                  ),
                ),
              ),
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.coral,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}