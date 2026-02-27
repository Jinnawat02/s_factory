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
        // 1. เรียกใช้ .execute() เพื่อดึงข้อมูลจริงออกมา
        final response = await ConnectorConnector.instance.getUser(email: user.email!).execute();

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
      const Center(child: QRScannerPage()),
      const Center(child: TaskListPage()),
      Center(child: Profile(user: _currentUser)), // use Profile(user: currentUser)
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
