import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomNavBar({super.key,});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
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