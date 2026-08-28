import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom nav 4 tab: Home / Informasi Sejarah / Collectible Card / Profil
/// (Design.md §2). Dipakai sama untuk user login & guest — kalau guest
/// tap "Collectible Card" atau "Profil", redirect guard di app_router.dart
/// yang otomatis mengarahkan ke /auth (R-GUEST-03), bukan disembunyikan
/// di sini, supaya guest tetap tahu fitur itu ada (mendorong registrasi,
/// sesuai prinsip "ramah untuk guest" di Design.md §1).
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            // Balik ke root tab kalau tab yang sama di-tap lagi.
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Sejarah',
          ),
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(Icons.style),
            label: 'Card',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
