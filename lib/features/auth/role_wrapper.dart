/// Role-based navigation wrapper for the s_factory application.
///
/// Responsible for fetching the authenticated user's role from the database
/// (or secure storage) and redirecting them to the appropriate home screen:
/// - **Admin** → [AdminHomeScreen]
/// - **Mechanic** → [MechanicHomeScreen]
/// - **User/Staff** → [UserHomeScreen]
///
/// Also handles initialization of Firebase Cloud Messaging (FCM).
///
/// @author Jinnawat Janngam
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../dataconnect_generated/generated.dart';
import '../../shared/services/secure_storage_service.dart';
import '../../shared/services/fcm_service.dart';

import '../admin/admin.dart';
import '../mechanic/mechanic.dart';
import '../user/user.dart';

/// A wrapper widget that manages the initial loading of user roles.
///
/// It acts as a middleman between the [AuthGate] and the main role-specific UI.
class RoleWrapper extends StatefulWidget {
  /// Creates a [RoleWrapper].
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

  /// Fetches the user role and initializes notification services.
  ///
  /// This method performs the following steps:
  /// 1. Validates the current authenticated user.
  /// 2. Calls [_getUserRole] to retrieve the role string.
  /// 3. Initializes [FcmService] if a role is found.
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

        // Initialize notification services for authorized users.
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

  /// Retrieves the user's role, checking secure storage first for speed.
  ///
  /// If the role is not cached locally, it queries the Firebase Data Connect
  /// backend and caches the result for future sessions.
  Future<String?> _getUserRole(String email) async {
    final storageService = SecureStorageService();
    
    // Try to get role from local cache first.
    String? cachedRole = await storageService.getRole();
    if (cachedRole != null) {
      return cachedRole;
    }

    // Fetch from database if not cached.
    final response = await ConnectorConnector.instance
        .getUser(email: email)
        .execute();
    final dataConnectUser = response.data.user;

    if (dataConnectUser != null) {
      String? role = dataConnectUser.role;
      if (role != null && role.isNotEmpty) {
        // Cache the role locally.
        await storageService.saveRole(role);
        return role;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while fetching role.
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Handle database or network errors.
    if (_error != null) {
      return Scaffold(body: Center(child: Text("Database Error: $_error")));
    }

    // Redirect to the appropriate dashboard based on role.
    if (_role != null) {
      if (_role == 'admin') {
        return const AdminHomeScreen();
      } else if (_role == 'mechanic') {
        return const MechanicHomeScreen();
      } else {
        return const UserHomeScreen();
      }
    }

    // Display Access Denied if no role is found for the authenticated email.
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
