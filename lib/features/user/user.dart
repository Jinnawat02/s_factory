import 'package:flutter/material.dart';
import 'package:s_factory/features/machine/machine_list_page.dart';
import 'package:s_factory/features/user/widgets/bottom_nav_bar.dart';

import '../../shared/widgets/nav_bar.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: 'S.Fac'),
      body: MachineListPage(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}