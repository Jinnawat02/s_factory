import 'package:flutter/material.dart';
import 'package:s_factory/shared/widgets/nav_bar.dart';

import '../mechanic//widgets/bottom_nav_bar.dart';

class MechanicHomeScreen extends StatelessWidget {
  const MechanicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: 'S.Fac'),
      body: const Center(child: Text("หน้านี้สำหรับช่าง (Mechanic)")),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}