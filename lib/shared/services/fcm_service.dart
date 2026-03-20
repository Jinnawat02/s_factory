/// Service for handling Firebase Cloud Messaging push notifications.
///
/// Contains logic for requesting user permissions, retrieving device tokens,
/// and routing the user to specific screens when notifications are tapped.
///
/// @author Thanat Phadinkaew
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../dataconnect_generated/generated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app.dart';
import '../../features/mechanic/task_detail.dart';

/// A singleton service that manages push notification permissions and foreground/background messaging.
class FcmService {
  static final FcmService _instance = FcmService._internal();
  factory FcmService() => _instance;
  FcmService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Requests notification permissions and sets up listeners for incoming messages and token refreshes.
  Future<void> initialize(BuildContext context) async {
    if (kIsWeb) {
      if (kDebugMode) print('FCM is disabled on Web.');
      return;
    }

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission for notifications');
      }

      String? token = await _messaging.getToken();

      if (token != null) {
        await saveTokenToDatabase(token);
      }

      _messaging.onTokenRefresh.listen(saveTokenToDatabase);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('Got a message whilst in the foreground!');
          print('Message data: \${message.data}');
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationTap(context, message);
      });

      RemoteMessage? initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(context, initialMessage);
      }
    }
  }

  /// Updates the authenticated user's device token in the backend database.
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
            builder: (context) => TaskDetailPage(requestId: requestId),
          ),
        );
      }
    }
  }
}
