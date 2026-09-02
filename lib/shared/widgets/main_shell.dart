import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom nav 4 tab: Home / Informasi / Koleksi / Profil (Design.md §2,
/// mockup Home terbaru). Dipakai sama untuk user login & guest — kalau
/// guest tap "Koleksi" atau "Profil", redirect guard di app_router.dart
/// yang otomatis mengarahkan ke /auth (R-GUEST-03), bukan disembunyikan
/// di sini, supaya guest tetap tahu fitur itu ada (mendorong registrasi,
/// sesuai prinsip "ramah untuk guest" di Design.md §1).
///
/// **Bottom nav custom** (bukan `NavigationBar` bawaan Material 3) —
/// alasan: butuh kontrol penuh atas 3 hal yang tidak bisa dicapai lewat
/// styling `NavigationBar` biasa:
/// 1. Tidak ada pill/background warna di belakang item aktif sama sekali.
/// 2. Titik indikator kecil di bawah label yang **bergeser** (bukan
///    fade in/out) mengikuti tab aktif.
/// 3. Hover khusus (web/desktop): item non-aktif tetap pudar warnanya,
///    tapi labelnya ikut muncul (pudar juga) selama di-hover.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    _NavItemData(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    _NavItemData(icon: Icons.menu_book_outlined, activeIcon: Icons.menu_book, label: 'Informasi'),
    _NavItemData(icon: Icons.style_outlined, activeIcon: Icons.style, label: 'Koleksi'),
    _NavItemData(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: navigationShell.currentIndex,
        items: _items,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            // Balik ke root tab kalau tab yang sama di-tap lagi.
            initialLocation: index == navigationShell.currentIndex,
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

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.selectedIndex,
    required this.items,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final List<_NavItemData> items;
  final ValueChanged<int> onDestinationSelected;

  static const double _barHeight = 72;
  static const double _dotSize = 5;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      child: DecoratedBox(
        // Garis tipis di atas, pengganti shadow/elevation — tetap kelihatan
        // sebagai batas dari konten di atasnya, tapi flat/putih bersih.
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0x14000000), width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: _barHeight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / items.length;

                return Stack(
                  children: [
                    Row(
                      children: List.generate(items.length, (index) {
                        return Expanded(
                          child: _NavItem(
                            data: items[index],
                            isActive: index == selectedIndex,
                            onTap: () => onDestinationSelected(index),
                          ),
                        );
                      }),
                    ),
                    // Titik indikator — cuma satu instance, posisinya
                    // di-animate tiap kali `selectedIndex` berubah, jadi
                    // efeknya "geser" dari tab lama ke tab baru, bukan
                    // muncul/hilang di masing-masing tab.
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      left: itemWidth * selectedIndex + itemWidth / 2 - (_dotSize / 2),
                      bottom: 10,
                      child: Container(
                        width: _dotSize,
                        height: _dotSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
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
  });

  final _NavItemData data;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  static const _activeColor = Colors.black;
  static const _fadedColor = Colors.black38;

  @override
  Widget build(BuildContext context) {
    // Label tampil kalau item aktif, ATAU kalau non-aktif tapi sedang
    // di-hover (warnanya tetap pudar, cuma labelnya yang nongol).
    final showLabel = widget.isActive || _isHovered;
    final color = widget.isActive ? _activeColor : _fadedColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Efek zoom halus saat aktif — scale-nya sengaja kecil
              // (1.0 -> 1.1) + curve easeOutCubic supaya terasa lembut,
              // bukan "lompat" mendadak.
              AnimatedScale(
                scale: widget.isActive ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: Icon(
                  widget.isActive ? widget.data.activeIcon : widget.data.icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                // Tetap reserve ruang meski opacity 0 (bukan
                // conditional-render), supaya tinggi tiap item konsisten
                // dan tidak ada layout yang "loncat" pas label muncul/hilang.
                opacity: showLabel ? 1 : 0,
                duration: const Duration(milliseconds: 180),
                child: Text(
                  widget.data.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                    color: color,
                  ),
                ),
              ),
              // Ruang kosong di bawah label — tempat titik indikator dari
              // parent `Stack` duduk (dot-nya sendiri dirender terpisah
              // di `_BottomNavBar`, bukan di sini per-item).
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}