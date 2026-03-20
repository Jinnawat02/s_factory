/// Admin home screen for the s_factory application.
///
/// Provides the root shell for the **admin** role, hosting bottom-tab
/// navigation between [MachineListPage], [UserListPage], and [InventoryPage].
///
/// @author Siwakorn Soemchatchroenkan
import 'package:flutter/material.dart';
import 'package:s_factory/features/inventory/inventory_page.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/user/user_list_page.dart';
import 'package:s_factory/shared/appbar/appbar.dart';
import 'package:s_factory/shared/navigation/navbar.dart';
import 'package:s_factory/shared/services/secure_storage_service.dart';

/// The root screen displayed to users with the **admin** role.
///
/// Manages a bottom [NavigationBar] with three tabs:
/// - **Home** → [MachineListPage]
/// - **Users** → [UserListPage]
/// - **Inventory** → [InventoryPage]
///
/// The current role is read from [SecureStorageService] on startup and
/// passed down to each child page so they can render role-appropriate UI.
class AdminHomeScreen extends StatefulWidget {
  /// Creates an [AdminHomeScreen].
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreen();
}

class _AdminHomeScreen extends State<AdminHomeScreen> {
  // สร้างตัวแปรเก็บว่ากำลังเลือกแท็บไหนอยู่ (ค่าเริ่มต้นคือ 0)
  int _selectedIndex = 0;
  String? _currentRole;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  /// Reads the authenticated user's role from local secure storage and
  /// stores it in [_currentRole].
  ///
  /// Throws an [Exception] if no role is found (should not happen after
  /// a successful login via [RoleWrapper]).
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

  List<Widget> get _pages => [
    MachineListPage(role: _currentRole!),
    UserListPage(role: _currentRole!),
    InventoryPage(role: _currentRole!),
  ];

  /// Updates [_selectedIndex] when the user taps a bottom-nav item.
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: SFactoryBottomNavbar(
        role: _currentRole!,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
