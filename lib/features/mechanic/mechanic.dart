import 'package:flutter/material.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/mechanic/task_list_page.dart';
import 'package:s_factory/shared/appbar/appbar.dart';
import 'package:s_factory/shared/navigation/navbar.dart';

import '../../shared/services/secure_storage_service.dart';

class MechanicHomeScreen extends StatefulWidget {
  const MechanicHomeScreen({super.key});

  @override
  State<MechanicHomeScreen> createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  // State to keep track of the selected tab index
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
        // หากไม่มี Role ใน Storage ให้เตะออกหรือจัดการ Error ตามเหมาะสม
        throw Exception('Role not found in secure storage');
      }
      setState(() {
        _currentRole = role;
        _isLoading = false;
      });
    }
  }

  // A list of pages to be displayed for each tab
  // TODO: Replace these with your actual screen widgets
  List<Widget> _getWidgetOptions() {
    return [
      Center(child: MachineListPage(role: _currentRole!)),
      const Center(child: Text('QR Scanner Page')),
      const Center(child: TaskListPage()),
      const Center(child: Text('Profile Page')),
    ];
  }

  // Callback function when a tab is tapped
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
      // Use the new configuration-based AppBar
      appBar: SFactoryAppBar(role: _currentRole!),
      // Display the page corresponding to the selected tab
      body: _getWidgetOptions().elementAt(_selectedIndex),
      // Use the new configuration-based BottomNavigationBar
      bottomNavigationBar: SFactoryBottomNavbar(
        role: _currentRole!,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
