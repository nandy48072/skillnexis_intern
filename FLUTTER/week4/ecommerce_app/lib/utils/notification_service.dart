import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // 1. Request permission (Required for Android 13+ and iOS)
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2. Setup Local Notifications for Foreground Alerts
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    // Fixed: using named parameter 'settings:'
    await _localNotifications.initialize(settings: initSettings);

    // 3. Get and Save Device Token to Firestore
    await saveDeviceToken();

    // Refresh token listener
    _messaging.onTokenRefresh.listen(_updateTokenInFirestore);

    // 4. Listen for Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
  }

  static Future<void> saveDeviceToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      await _updateTokenInFirestore(token);
    }
  }

  static Future<void> _updateTokenInFirestore(String token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fcmToken': token,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'ecommerce_channel',
      'Order & Promo Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    // Fixed: using named parameters for show()
    await _localNotifications.show(
      id: message.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: details,
    );
  }

  static Future<void> showOrderConfirmedNotification({
    required String orderId,
    required double totalAmount,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'order_updates_channel', // Channel ID
      'Order Updates', // Channel Name
      channelDescription: 'Notifications for order confirmations and updates',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000, // Unique ID per order
      title: 'Order Confirmed! 📦',
      body: 'Your order #$orderId (₹${totalAmount.toStringAsFixed(0)}) has been placed successfully.',
      notificationDetails: platformDetails,
    );
  }
}