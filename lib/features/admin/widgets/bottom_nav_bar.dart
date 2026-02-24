import 'package:flutter/material.dart';
import 'package:s_factory/features/inventory/inventory_page.dart';

class BottomNavBar extends StatelessWidget implements PreferredSizeWidget {
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
