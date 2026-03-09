import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../dataconnect_generated/generated.dart';
import '../../shared/services/secure_storage_service.dart';
import '../../shared/services/fcm_service.dart';

import '../admin/admin.dart';
import '../mechanic/mechanic.dart';
import '../user/user.dart';

class RoleWrapper extends StatefulWidget {
  const RoleWrapper({super.key});

  @override
  State<RoleWrapper> createState() => _RoleWrapperState();
}

class _RoleWrapperState extends State<RoleWrapper> {
  String? _role;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRoleAndInitializeFcm();
  }

  Future<void> _loadRoleAndInitializeFcm() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) {
      if (mounted) {
        setState(() {
          _error = "Error: User email is missing";
          _isLoading = false;
        });
      }
      return;
    }

    try {
      final role = await _getUserRole(user.email!);
      if (mounted) {
        setState(() {
          _role = role;
          _isLoading = false;
        });

        if (role != null) {
          FcmService().initialize(context);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<String?> _getUserRole(String email) async {
    final storageService = SecureStorageService();
    String? cachedRole = await storageService.getRole();
    if (cachedRole != null) {
      return cachedRole;
    }

    final response = await ConnectorConnector.instance
        .getUser(email: email)
        .execute();
    final dataConnectUser = response.data.user;

    if (dataConnectUser != null) {
      String? role = dataConnectUser.role;
      if (role != null && role.isNotEmpty) {
        await storageService.saveRole(role);
        return role;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(body: Center(child: Text("Database Error: $_error")));
    }

    if (_role != null) {
      if (_role == 'admin') {
        return const AdminHomeScreen();
      } else if (_role == 'mechanic') {
        return const MechanicHomeScreen();
      } else {
        return const UserHomeScreen();
      }
    }

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
}
