/// Authentication gate for the s_factory application.
///
/// Determines whether to show the sign-in screen or the application's
/// main content ([RoleWrapper]) based on the user's current authentication state.
///
/// @author Jinnawat Janngam
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:s_factory/features/auth/role_wrapper.dart';

/// A widget that listens to the Firebase authentication state.
///
/// If the user is not authenticated, it renders a customized [SignInScreen]
/// with project-specific branding and theme. Once the user signs in, it
/// returns the [RoleWrapper] to handle role-based navigation.
class AuthGate extends StatelessWidget {
  /// Creates an [AuthGate].
  ///
  /// The [clientId] is required for certain authentication providers (e.g., Google).
  const AuthGate({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the snapshot has no data, the user is not authenticated.
        if (!snapshot.hasData) {
          return Theme(
            data: ThemeData(
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Colors.transparent,
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white,
                ),
              ),
              colorScheme: const ColorScheme.dark(
                onSurface: Colors.white,
                primary: Colors.white,
              ),
            ),
            child: SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
              actions: [
                ForgotPasswordAction((context, email) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password resets are managed by Admins.'))
                  );
                }),
              ],
              showPasswordVisibilityToggle: true,
              showAuthActionSwitch: false,
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
                  child: Text(
                    'Welcome to the system, please sign in.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              footerBuilder: (context, action) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
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
            ),
          );
        }

        // Proceed to RoleWrapper once authenticated.
        return const RoleWrapper();
      },
    );
  }
}
