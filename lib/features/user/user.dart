import 'package:flutter/material.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/user/request_list_page.dart';
import 'package:s_factory/features/user/widgets/mechanics_list.dart';
import 'package:s_factory/shared/appbar/appbar.dart';
import 'package:s_factory/shared/navigation/navbar.dart';
import '../../shared/services/secure_storage_service.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
    const Center(child: Text('QR Scanner Page (ยังไม่ได้ใส่หน้าจริง)')),
    const RequestListPage(),
    const MechanicsList(),
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
