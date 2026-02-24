import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  // คีย์สำหรับเก็บข้อมูล
  final String _roleKey = 'user_role';

  // 1. บันทึก Role ลงเครื่อง
  Future<void> saveRole(String role) async {
    await _storage.write(key: _roleKey, value: role);
  }

  // 2. ดึง Role จากเครื่อง
  Future<String?> getRole() async {
    return await _storage.read(key: _roleKey);
  }

  // 3. ลบ Role ออกจากเครื่อง (สำคัญมาก: ต้องเรียกใช้ตอน Logout)
  Future<void> clearRole() async {
    await _storage.delete(key: _roleKey);
  }
}