import 'package:firebase_messaging/firebase_messaging.dart';

import '../../dataconnect_generated/generated.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// ขอสิทธิการส่งแจ้งเตือน (สำคัญมากสำหรับ iOS)
  static Future<void> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  /// ดึง FCM Token แล้วอัพเดตลงใน Firebase Data Connect
  static Future<void> setupFCMToken(String userEmail) async {
    try {
      // 1. ขอสิทธิ
      await requestPermission();

      // 2. ขอ Device Token
      String? token = await _messaging.getToken(
        vapidKey:
            "BG_fzG7uKufhr8raP3TrgKTfcVMx32mj45fjw7WohSZq7f-LxykmYD0pPw-tqDEfeB9zoEzQi6BXnrnbCXvXthM",
      );

      if (token != null) {
        print('FCM Token: $token');
        // 3. บันทึก Token ลง Data Connect
        await ConnectorConnector.instance
            .updateUserFcmToken(email: userEmail, token: token)
            .execute();
        print('Successfully updated FCM token for $userEmail');
      }

      // 4. (Optional) ติดตามการเปลี่ยน Token ในอนาคต
      _messaging.onTokenRefresh.listen((newToken) {
        ConnectorConnector.instance
            .updateUserFcmToken(email: userEmail, token: newToken)
            .execute();
      });
    } catch (e) {
      print('Error setting up FCM: $e');
    }
  }

  /// (Optional) การตั้งค่า Listener สำหรับ Foreground Message
  static void initializeForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a FCM message whilst in the foreground!');
      print('Message data: \${message.data}');

      if (message.notification != null) {
        print(
          '🔥 FCM Notification Title: \${message.notification?.title}, Body: \${message.notification?.body}',
        );
      }
    });
  }
}
