import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../dataconnect_generated/generated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app.dart';
import '../../features/mechanic/task_detail.dart';

class FcmService {
  static final FcmService _instance = FcmService._internal();
  factory FcmService() => _instance;
  FcmService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize(BuildContext context) async {
    // Web push notifications are explicitly disabled.
    if (kIsWeb) {
      if (kDebugMode) print('FCM is disabled on Web.');
      return;
    }

    // 1. Request permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission for notifications');
      }

      // 2. Get the token
      String? token = await _messaging.getToken();

      if (token != null) {
        await saveTokenToDatabase(token);
      }

      // 3. Listen to token updates
      _messaging.onTokenRefresh.listen(saveTokenToDatabase);

      // 4. Handle messages while app is in foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('Got a message whilst in the foreground!');
          print('Message data: \${message.data}');
        }
        // Since the prompt asks to NOT do foreground notifications for now:
        // "ณ ตอนนี้ให้ทำเป็นแบบแจ้งเตือนขณะที่ไม่ได้เปิดแอปก็พอยังไม่ต้องทำแจ้งเตือนขณะเปิดแอป"
        // We will just log it and do nothing visible.
      });

      // 5. Handle tapping on a background message
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationTap(context, message);
      });

      // 6. Handle app launched from terminated state via notification
      RemoteMessage? initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(context, initialMessage);
      }
    }
  }

  Future<void> saveTokenToDatabase(String token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      try {
        await ConnectorConnector.instance
            .updateFcmToken(email: user.email!, fcmToken: token)
            .execute();
        if (kDebugMode) {
          print('FCM Token updated successfully in Data Connect: $token');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error updating FCM Token: $e');
        }
      }
    }
  }

  void _handleNotificationTap(BuildContext context, RemoteMessage message) {
    if (message.data.containsKey('requestId')) {
      final requestId = message.data['requestId'];
      if (kDebugMode) print('Tapped notification with requestId: $requestId');

      final context = navigatorKey.currentContext;
      if (context != null) {
        // Navigate to TaskDetailPage with the requestId
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(
              requestId: requestId,
            ),
          ),
        );
      }
    }
  }
}
