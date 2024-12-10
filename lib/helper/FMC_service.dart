import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initFCM() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _fetchAndLogToken();

      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print("Updated FCM Token: $newToken");
      });

      print("FCM is set up successfully.");
    } else {
      print("User denied notification permissions.");
    }
  }

  Future<void> _fetchAndLogToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print("Initial FCM Token: $token");
      } else {
        print("Failed to fetch FCM token.");
      }
    } catch (e) {
      print("Error fetching FCM token: $e");
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _showLocalNotification(message);
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    _showLocalNotification(message);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'task_channel',
        'Task Notifications',
        importance: Importance.high,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('notification_sound'),
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}
