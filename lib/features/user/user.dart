import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../mock/machine_mock_data.dart';
import '../../shared/widgets/machine_card.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('รายการเครื่องจักร'),
          actions: [
            IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          if (constraints.maxWidth > 900) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 600) {
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
    );
  }
}