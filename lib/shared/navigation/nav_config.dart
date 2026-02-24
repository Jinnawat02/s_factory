import 'package:flutter/material.dart';

/// A class to hold the UI configuration for navigation components.
/// This centralizes the appearance logic for different user roles.
class NavConfig {
  /// Returns configurations for the BottomNavigationBar.
  static Map<String, List<Map<String, dynamic>>> getBottomNavConfigs() {
    return {
      'admin': [
        {
          'icon': Icons.home_outlined,
          'activeIcon': Icons.home,
          'label': 'Home',
        },
        {
          'icon': Icons.people_outline,
          'activeIcon': Icons.people,
          'label': 'Users',
        },
        // {
        //   'icon': Icons.bar_chart_outlined,
        //   'activeIcon': Icons.bar_chart,
        //   'label': 'Reports',
        // },
        {
          'icon': Icons.inventory_2_outlined,
          'activeIcon': Icons.inventory_2,
          'label': 'Inventory',
        },
      ],
      'mechanic': [
        {
          'icon': Icons.home_outlined,
          'activeIcon': Icons.home,
          'label': 'Home',
        },
        {
          'icon': Icons.qr_code_scanner,
          'activeIcon': Icons.qr_code_scanner,
          'label': 'Scan',
        },
        {
          'icon': Icons.assignment,
          'activeIcon': Icons.assignment,
          'label': 'Tasks',
        },
        {
          'icon': Icons.account_circle,
          'activeIcon': Icons.account_circle,
          'label': 'Profile',
        },
      ],
      'user': [
        {
          'icon': Icons.home_outlined,
          'activeIcon': Icons.home,
          'label': 'Home',
        },
        {
          'icon': Icons.qr_code_scanner,
          'activeIcon': Icons.qr_code,
          'label': 'Scan',
        },
        {
          'icon': Icons.list_alt_outlined,
          'activeIcon': Icons.list_alt,
          'label': 'My Requests',
        },
        {
          'icon': Icons.engineering,
          'activeIcon': Icons.engineering,
          'label': 'Contact',
        },
      ],
      'default': [
        {
          'icon': Icons.home_outlined,
          'activeIcon': Icons.home,
          'label': 'Home',
        },
      ],
    };
  }
}
