import 'package:flutter/material.dart';

import 'nav_config.dart'; // Import the config file

/// A configuration-based BottomNavigationBar that changes its items
/// based on the user's role.
class SFactoryBottomNavbar extends StatelessWidget {
  const SFactoryBottomNavbar({
    super.key,
    required this.role,
    required this.currentIndex,
    required this.onTap,
  });

  final String role;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    // Get all configurations from the NavConfig class
    final allConfigs = NavConfig.getBottomNavConfigs();

    // Look up the configuration for the current role, or use the default.
    final config = allConfigs[role] ?? allConfigs['default']!;

    // Create the list of BottomNavigationBarItem from the config
    final items = config.map((itemConfig) {
      return BottomNavigationBarItem(
        icon: Icon(itemConfig['icon'] as IconData),
        activeIcon: Icon(itemConfig['activeIcon'] as IconData),
        label: itemConfig['label'] as String,
      );
    }).toList();

    return BottomNavigationBar(
      backgroundColor: Colors.deepOrange,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.white,
    );
  }
}
