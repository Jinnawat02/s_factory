/// Main home screen for users in the s_factory application.
/// 
/// This widget acts as a structural shell that manages top-level navigation,
/// fetching the user's role and displaying the appropriate sub-pages.
///
/// @author Jinnawat Janngam
import 'package:flutter/material.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/user/request_list_page.dart';
import 'package:s_factory/features/user/widgets/mechanics_list.dart';

import 'package:s_factory/shared/appbar/appbar.dart';
import 'package:s_factory/shared/navigation/navbar.dart';
import '../../shared/services/secure_storage_service.dart';
import '../qr/qr_scanner.dart';

/// A stateful widget that displays the primary navigation interface.
/// 
/// It coordinates the [SFactoryAppBar], the main content area ([_pages]), 
/// and the [SFactoryBottomNavbar].
class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  /// Index of the currently selected tab in the bottom navigation bar.
  int _selectedIndex = 0;

  /// The role of the current user (e.g., 'admin', 'user') fetched from secure storage.
  String? _currentRole;

  /// Flag to track if the role is still being loaded from storage.
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  /// Retrieves the user's role from [SecureStorageService].
  /// 
  /// Throws an [Exception] if no role is found. Once retrieved, updates 
  /// the state to stop the loading indicator and render the UI.
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

  /// A list of destination widgets available in the navigation bar.
  List<Widget> get _pages => [
    MachineListPage(role: _currentRole!),
    const QRScannerPage(),
    const RequestListPage(),
    MechanicsList(role: _currentRole!),
  ];

  /// Updates the [_selectedIndex] when a navigation item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading spinner while waiting for the user role to be fetched.
    if (_isLoading || _currentRole == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: SFactoryAppBar(role: _currentRole!),
      body: _pages[_selectedIndex],
      bottomNavigationBar: SFactoryBottomNavbar(
        role: _currentRole!,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
