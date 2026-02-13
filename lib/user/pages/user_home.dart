import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("รายการแจ้งซ่อมของฉัน")),
      // ปุ่มสำหรับแจ้งซ่อมใหม่
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // เพิ่มข้อมูลเข้า database
          FirebaseFirestore.instance.collection('requests').add({
            'title': 'แจ้งซ่อมคอมพิวเตอร์ ${DateTime.now().minute}', // ตัวอย่าง
            'status': 'pending', // รอรับงาน
            'owner_id': user?.uid,
            'created_at': FieldValue.serverTimestamp(),
          });
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Query: ดึงเฉพาะของ user คนนี้
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where('owner_id', isEqualTo: user?.uid)
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('เกิดข้อผิดพลาด'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              var item = data.docs[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.build_circle, color: Colors.blue),
                  title: Text(item['title']),
                  subtitle: Text("สถานะ: ${item['status']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}