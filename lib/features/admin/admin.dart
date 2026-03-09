import 'package:flutter/material.dart';
import 'package:s_factory/features/inventory/inventory_page.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/user/user_list_page.dart';
import 'package:s_factory/shared/appbar/appbar.dart';
import 'package:s_factory/shared/navigation/navbar.dart';
import 'package:s_factory/shared/services/secure_storage_service.dart';

class AdminHomeScreen extends StatefulWidget {
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
