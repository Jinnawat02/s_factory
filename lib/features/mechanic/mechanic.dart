/// Home screen for mechanics to navigate the application.
/// 
/// Provides a bottom navigation bar to switch between the
/// machine list, QR scanner, task list, and user profile.
/// Fetches the current user's profile and role to configure the UI.
///
/// @author Thanat Phadinkaew
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/mechanic/task_list_page.dart';
import 'package:s_factory/features/profile/profile.dart';
import 'package:s_factory/features/qr/qr_scanner.dart';
import 'package:s_factory/shared/appbar/appbar.dart';
import 'package:s_factory/shared/navigation/navbar.dart';

import '../../dataconnect_generated/generated.dart';
import '../../shared/services/secure_storage_service.dart';

/// A screen that manages tabbed navigation and role-based access for mechanics.
class MechanicHomeScreen extends StatefulWidget {
  /// Creates a [MechanicHomeScreen].
  const MechanicHomeScreen({super.key});

  @override
  State<MechanicHomeScreen> createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  int _selectedIndex = 0;
  
  String? _currentRole;
  
  bool _isLoading = true;
  
  dynamic _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      try {
        final response = await ConnectorConnector.instance
            .getUser(email: user.email!)
            .execute();

        if (mounted) {
          setState(() {
            _currentUser = response.data.user;
            _isLoading = false;
          });

          debugPrint('User Name: ${_currentUser?.name}');
        }
      } catch (e) {
        debugPrint('Error: $e');
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadUserRole() async {
    final role = await SecureStorageService().getRole();
    if (mounted) {
      if (role == null || role.isEmpty) {
        throw Exception('Role not found in secure storage');
      }
      setState(() {
        _currentRole = role;
        _isLoading = false;
      });
    }
  }

  List<Widget> _getWidgetOptions() {
    return [
      Center(child: MachineListPage(role: _currentRole!)),
      const Center(child: QRScannerPage()),
      const Center(child: TaskListPage()),
      Center(
        child: Profile(
          user: _currentUser,
          isOwnProfile: true,
          isShowOnlyCalendar: true,
        ),
      ), // use Profile(user: currentUser)
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _currentRole == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: SFactoryAppBar(role: _currentRole!),
      body: _getWidgetOptions().elementAt(_selectedIndex),
      bottomNavigationBar: SFactoryBottomNavbar(
        role: _currentRole!,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
