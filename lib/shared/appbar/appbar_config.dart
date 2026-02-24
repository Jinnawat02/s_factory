import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/secure_storage_service.dart';

/// A class to hold the UI configuration for the SFactoryAppBar.
/// This centralizes the appearance logic for different user roles.
class AppBarConfig {
  /// Returns configurations for the AppBar.
  static Map<String, Map<String, dynamic>> getAppBarConfigs() {
    return {
      'admin': {
        'title': const Text('Admin Dashboard'),
        'actions': (BuildContext context) => <Widget>[
          IconButton(
            icon: const Icon(Icons.people_outline),
            tooltip: 'Manage Users',
            onPressed: () {
              // TODO: Navigate to User Management Screen
            },
          ),
        ],
      },
      'mechanic': {
        'title': const Text('Mechanic Dashboard'),
        'actions': (BuildContext context) => <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await SecureStorageService().clearRole();
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      },
      'user': {
        'title': const Text('S-Factory'),
        'actions': (BuildContext context) => <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await SecureStorageService().clearRole();
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      },
      // Default configuration as a fallback
      'default': {
        'title': const Text('S-Factory'),
        'actions': (BuildContext context) => <Widget>[],
      },
    };
  }
}
