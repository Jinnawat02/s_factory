/// Service for managing securely stored local data.
///
/// Provides a wrapper around Flutter Secure Storage to persist user
/// session data across app restarts.
///
/// @author Thanat Phadinkaew
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A service that reads and writes the user's role to encrypted local storage.
class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  final String _roleKey = 'user_role';

  /// Persists the user's role to secure storage.
  Future<void> saveRole(String role) async {
    await _storage.write(key: _roleKey, value: role);
  }

  /// Retrieves the user's role from secure storage.
  Future<String?> getRole() async {
    return await _storage.read(key: _roleKey);
  }

  /// Removes the user's role from secure storage.
  Future<void> clearRole() async {
    await _storage.delete(key: _roleKey);
  }
}
