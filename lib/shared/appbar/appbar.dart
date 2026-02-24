import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/secure_storage_service.dart';

import 'appbar_config.dart'; // Import the new config file

/// A configuration-based AppBar that changes its title and actions
/// based on the user's role.
class SFactoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SFactoryAppBar({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    // Get all configurations from the AppBarConfig class
    final allConfigs = AppBarConfig.getAppBarConfigs();

    // Look up the configuration for the current role, or use the default.
    final config = allConfigs[role] ?? allConfigs['default']!;

    // Get the specific actions for the role
    final List<Widget> roleActions = config['actions'](context);

    return AppBar(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      title: config['title'],
      actions: [
        ...roleActions,
        // Common actions for all roles except mechanics and users who have a direct logout
        if (role == 'admin') _buildPopupMenu(context),
      ],
    );
  }

  /// Builds the common popup menu for Profile and Logout.
  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'profile') {
          // TODO: Implement navigation to Profile Screen
        } else if (value == 'logout') {
          await SecureStorageService().clearRole();
          await FirebaseAuth.instance.signOut();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'profile',
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Profile'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
