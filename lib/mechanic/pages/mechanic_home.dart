import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MechanicHomeScreen extends StatelessWidget {
  const MechanicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("งานซ่อมที่รอรับ (Mechanic)"),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Query: ดึงงานที่ยังไม่มีคนทำ (pending)
        stream: FirebaseFirestore.instance
            .collection('requests')
        // .where('status', isEqualTo: 'pending') // เปิดบรรทัดนี้ถ้าอยากกรอง
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Error loading jobs');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              var item = data.docs[index];
              return Card(
                color: Colors.orange.shade50,
                child: ListTile(
                  title: Text(item['title']),
                  subtitle: Text("Status: ${item['status']}"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // กดเพื่อรับงาน (เปลี่ยนสถานะเป็น fixing)
                      FirebaseFirestore.instance
                          .collection('requests')
                          .doc(item.id)
                          .update({'status': 'fixing'});
                    },
                    child: const Text("รับงาน"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}