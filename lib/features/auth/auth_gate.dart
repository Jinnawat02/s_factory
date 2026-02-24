import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:s_factory/features/auth/role_wrapper.dart';

// เนื่องจากเราจะย้ายตรรกะการดึงข้อมูลและเช็ค Role ไปไว้ที่ RoleWrapper
// หน้านี้จึงทำหน้าที่แค่จัดการ UI การล็อกอินเท่านั้น

class AuthGate extends StatelessWidget {
  const AuthGate({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: clientId),
            ],
            // ลบ actions: [ AuthStateChangeAction<UserCreated>... ] ออกไปเลย
            // เพราะเราไม่ต้องการให้มีการเซฟข้อมูลลงฐานข้อมูลตอนมีคนพยายามสมัคร
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/logo_no_bg.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                // เปลี่ยนข้อความให้เหมาะสมกับระบบปิด
                child: Text('Welcome to the system, please sign in.'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  // แจ้งเตือนผู้ใช้ว่าเป็นระบบภายใน
                  'Internal system only. Accounts are managed by administrators.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/logo_no_bg.png'),
                ),
              );
            },
          );
        }

        // เมื่อเข้าสู่ระบบสำเร็จ (ได้ User กลับมา)
        // จะส่งไปให้ RoleWrapper จัดการดึงข้อมูลจาก Data Connect ต่อ
        return const RoleWrapper();
      },
    );
  }
}