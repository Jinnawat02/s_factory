import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String role; // admin, mechanic, user
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      role: map['role'] ?? 'user',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  static Map<String, dynamic> createInitialData({
    required String email,
    String? displayName,
    String role = 'user',
  }) {
    return {
      'email': email,
      'displayName': displayName ?? '',
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}