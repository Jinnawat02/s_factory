import 'package:flutter/material.dart';
import 'package:s_factory/models/machine_data.dart';
import 'send_request.dart';

class MachineDetailScreen extends StatelessWidget {
  final Machine machine;

  const MachineDetailScreen({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          machine.name,
          style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFE9A15F), // The orange/tan background from wireframe
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Image Placeholder Box
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Image.network(
                machine.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_outlined,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Description Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                machine.description,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 40),

            // Maintenance Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SendRequestScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Request Maintainance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
