import 'package:flutter/material.dart';
import 'package:s_factory/shared/widgets/nav_bar.dart';

import '../admin/widgets/bottom_nav_bar.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: "S.Fac"),
      body: const Center(child: Text("หน้านี้สำหรับผู้ดูแลระบบ (Admin Only)")),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}