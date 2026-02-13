import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin/admin.dart';
import '../mechanic/mechanic.dart';
import '../user/user.dart';

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return const Center(child: Text("Error: No User Found"));

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        // 1. ระหว่างรอโหลดข้อมูล ให้หมุนติ้วๆ
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data!.exists) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          String role = data['role'] ?? 'user';

          if (role == 'admin') {
            return const AdminHomeScreen();
          } else if (role == 'mechanic') {
            return const MechanicHomeScreen();
          } else {
            return const UserHomeScreen();
          }
        }

        return const UserHomeScreen();
      },
    );
  }
}