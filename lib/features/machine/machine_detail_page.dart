import 'package:flutter/material.dart';
import 'package:s_factory/features/machine/request_form_page.dart';

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
        leadingText: 'Cancel',
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

                  const SizedBox(height: 30),

                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestFormPage(
                                machineName: machineData['name']!,
                                machineID: machineData['id']!,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.send),
                        label: const Text(
                          'ส่งคำร้องซ่อม/บำรุง',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}