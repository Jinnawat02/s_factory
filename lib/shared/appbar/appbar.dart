import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s_factory/features/profile/profile.dart';

import '../../dataconnect_generated/generated.dart';
import '../services/secure_storage_service.dart';

import '../widgets/nav_bar.dart';
import 'appbar_config.dart'; // Import the new config file

/// A configuration-based AppBar that changes its title and actions
/// based on the user's role.
class SFactoryAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SFactoryAppBar({super.key, required this.role});

  final String role;

  @override
  State<SFactoryAppBar> createState() => _SFactoryAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SFactoryAppBarState extends State<SFactoryAppBar> {
  dynamic _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final allConfigs = AppBarConfig.getAppBarConfigs();
    final config = allConfigs[widget.role] ?? allConfigs['default']!;

    return AppBar(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      title: config['title'],
      actions: [
        _buildPopupMenu(context),
      ],
    );
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      try {
        final response = await ConnectorConnector.instance
            .getUser(email: user.email!)
            .execute();

        setState(() {
          _currentUser = response.data.user;
        });
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'profile') {
          if (_currentUser == null) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: const NavBar(title: 'Profile', leadingText: 'Back'),
                body: Profile(user: _currentUser),
              )
            ),
          );
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
}
