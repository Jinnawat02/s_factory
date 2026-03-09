import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/auth/auth_gate.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Added for deep linking Without context
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF2E2E32),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        fontFamily: GoogleFonts.oswald().fontFamily,
      ),
      home: AuthGate(clientId: clientId),
    );
  }
}
