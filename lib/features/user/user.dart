import 'package:flutter/material.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/user/widgets/bottom_nav_bar.dart';
import 'package:s_factory/features/user/widgets/mechanics_list.dart';

import '../../shared/widgets/nav_bar.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // สร้างตัวแปรเก็บว่ากำลังเลือกแท็บไหนอยู่ (ค่าเริ่มต้นคือ 0)
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MachineListPage(),
    Center(child: Text('Request List Page (ยังไม่ได้ใส่หน้าจริง)')),
    Center(child: Text('QR Scanner Page (ยังไม่ได้ใส่หน้าจริง)')),
    MechanicsList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: 'S.Fac'),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}