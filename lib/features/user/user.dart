import 'package:flutter/material.dart';
import 'package:s_factory/features/user/widgets/bottom_nav_bar.dart';

import '../../mock/machine_mock_data.dart';
import '../../shared/widgets/machine_card.dart';
import '../../shared/widgets/nav_bar.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: 'S.Fac'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          if (constraints.maxWidth > 840) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 420) {
            crossAxisCount = 2;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 320,
            ),
            itemCount: MachineMockData.machines.length,
            itemBuilder: (context, index) {
              final item = MachineMockData.machines[index];
              return MachineCard(
                name: item['name']!,
                description: item['description']!,
                imageUrl: item['imageUrl']!,
                onTap: () => print('Selected: ${item['name']}'),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}