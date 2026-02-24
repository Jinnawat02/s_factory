import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../dataconnect_generated/generated.dart';
// Import คลาส Service ที่เราเพิ่งสร้าง
import '../../shared/services/secure_storage_service.dart';

import '../admin/admin.dart';
import '../mechanic/mechanic.dart';
import '../user/user.dart';

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({super.key});

  // สร้างฟังก์ชันจัดการตรรกะการดึงข้อมูล
  Future<String?> _getUserRole(String email) async {
    final storageService = SecureStorageService();

    // 1. ลองค้นหา Role จากในเครื่องมือถือก่อน (ไวมาก)
    String? cachedRole = await storageService.getRole();
    if (cachedRole != null) {
      print('เจอข้อมูลใน Cache: $cachedRole');
      return cachedRole;
    }

    // 2. ถ้าในเครื่องไม่มี (เพิ่งล็อกอินครั้งแรก) ให้ไปดึงจาก Data Connect
    print('ไม่เจอ Cache กำลังดึงข้อมูลจาก Data Connect...');
    final response = await ConnectorConnector.instance
        .getUser(email: email)
        .execute();
    final dataConnectUser = response.data.user;

    if (dataConnectUser != null) {
      String? role = dataConnectUser.role;

      if (role != null && role.isNotEmpty) {
        // 3. ได้ข้อมูลมาแล้ว เอาไปเซฟลงเครื่องไว้ใช้รอบหน้า
        await storageService.saveRole(role);
        return role;
      } else {
        // กรณีพบ User ในระบบ แต่ไม่ได้ระบุ Role
        print('Warning: User found but no role assigned');
        return null;
      }
    }

    // กรณีหาไม่เจอในระบบ
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return const Center(child: Text("Error: No User Found"));

    final userEmail = user.email;
    if (userEmail == null || userEmail.isEmpty) {
      return const Center(child: Text("Error: User email is missing"));
    }

    return FutureBuilder<String?>(
      // ⚡️ เรียกใช้ฟังก์ชันที่เราเขียนไว้ด้านบน ⚡️
      future: _getUserRole(userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Database Error: ${snapshot.error}")),
          );
        }

        // snapshot.data ตอนนี้คือ String ของ Role แล้ว (เช่น 'admin', 'mechanic')
        final role = snapshot.data;

        if (role != null) {
          if (role == 'admin') {
            return const AdminHomeScreen();
          } else if (role == 'mechanic') {
            return const MechanicHomeScreen();
          } else {
            return const UserHomeScreen();
          }
        } else {
          // คืนค่า null แปลว่าไม่มีข้อมูลใน Data Connect
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Access Denied: Account not found in the system.\nPlease contact administrator.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: const Text("Sign Out"),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
