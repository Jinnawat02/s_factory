/// Admin bottom navigation bar widget for the s_factory application.
///
/// @author Siwakorn Soemchatchroenkan
import 'package:flutter/material.dart';

/// A simple bottom navigation bar used on the admin screen.
///
/// Implements [PreferredSizeWidget] so it can be placed directly in
/// [Scaffold.bottomNavigationBar]. Contains **Add** and **Inventory** tabs
/// styled with a deep-orange background.
///
/// > **Note**: This widget is a legacy component. The main navigation bar
/// > for all roles is now handled by `SFactoryBottomNavbar` in
/// > `shared/navigation/navbar.dart`.
class BottomNavBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [BottomNavBar].
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2),
          label: 'Inventory',
        ),
      ],
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.deepOrange,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
