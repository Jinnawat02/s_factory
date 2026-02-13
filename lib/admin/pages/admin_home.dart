import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แผงควบคุม (Admin)"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Query: ดึงมาทั้งหมด ไม่สนใคร
        stream: FirebaseFirestore.instance
            .collection('requests')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Error');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              var item = data.docs[index];
              return ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: Text(item['title']),
                subtitle: Text("User ID: ${item['owner_id']}"), // แอดมินเห็น ID ด้วย
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // ปุ่มลบงานทิ้ง
                    FirebaseFirestore.instance
                        .collection('requests')
                        .doc(item.id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}