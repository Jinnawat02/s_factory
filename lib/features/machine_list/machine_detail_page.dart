import 'package:flutter/material.dart';

import '../../shared/widgets/nav_bar.dart';

class MachineDetailPage extends StatelessWidget {
  final Map<String, String> machineData;

  const MachineDetailPage({super.key, required this.machineData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // เรียกใช้ NavBar ของเรา พร้อมส่งค่า leadingText เพื่อให้กดกลับได้
      appBar: NavBar(
        title: machineData['name']!,
        leadingText: 'Back',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              machineData['imageUrl']!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'รายละเอียดเครื่องจักร',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    machineData['description']!,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}