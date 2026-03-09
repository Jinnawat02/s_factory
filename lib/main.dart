import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'app.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final clientId = dotenv.env['WEB_CLIENT_ID'] ?? '';
  final iOSClientId = dotenv.env['IOS_CLIENT_ID'] ?? '';

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (kDebugMode) {
  //   // 10.0.2.2 is the 'localhost' for Android Emulators
  //   // 127.0.0.1 or localhost works for iOS/Web
  //   String host = defaultTargetPlatform == TargetPlatform.android
  //       ? '10.0.2.2'
  //       : 'localhost';
  //   ConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, 9399);
  // }

  runApp(MyApp(clientId: clientId));
}
