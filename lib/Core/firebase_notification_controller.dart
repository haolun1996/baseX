import 'package:flutter/foundation.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:baseX/base_x.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

/// Firebase Messaging will auto initialize when class is pass into runEtcApp
///
/// Below are the list of function are required to override:
/// 1. onReceiveToken => FcmToken will be pass to this function for any addition process required, fcm token will auto save to share preference
/// 2. onErrorToken => Function will run will fail to retreive fcm token
/// 3. onLaunchMessage => Function will run when App is opened and initialized via notification
/// 4. onMessage => Function will run when notification is received while App is active
/// 5. onMessageOpenedApp => Function will run when notification is tapped when App is inactive in background
///
/// Below are the list of variable to set for iOS only:
/// 1. soundEnable
/// 2. badgeEnable
/// 3. alertEnable
abstract class FirebaseNotificationController<T> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //Local Channel
  AndroidNotificationChannel get channel => AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound(notificationSoundFile),
      );

  ///Set Notification Custom Sound file name
  String get notificationSoundFile => 'default';

  ///Enable Sound Setting
  bool get soundEnable => true;

  ///Enable Badge Setting
  bool get badgeEnable => true;

  ///Enable Alert Setting
  bool get alertEnable => true;

  ///Receive FCM Token Function
  void onReceiveToken(String? token);

  ///On Error Receive FCM Token Funtion
  void onErrorToken(dynamic error);

  ///On Launch Message Function
  void onLaunchMessage(RemoteMessage? message);

  ///On Foreground Message Function
  void onMessage(RemoteMessage? message);

  ///On Background Message Function
  void onMessageOpenedApp(RemoteMessage? message);

  ///Dynamic Reactive Type
  Rx<T?> notificationData = Rx(null);

  //Initialize Function
  void initialize() async {
    _createChannel();
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        sound: soundEnable, badge: badgeEnable, alert: alertEnable);
    if (kDebugMode) {
      print('User granted permissions: ${settings.authorizationStatus}');
    }

    _firebaseMessaging.getToken().then((token) async {
      if (token != null) {
        onReceiveToken(token);
      }
      if (kDebugMode) {
        print('fcmToken: $token');
      }
    }).catchError((error) {
      onErrorToken(error);
      if (kDebugMode) {
        print('fcmError $error');
      }
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (kDebugMode) {
        print('onLaunch: $initialMessage');
      }
      onLaunchMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (kDebugMode) {
        print('onMessage: {notification: ${event.notification?.body}, data: ${event.data}}');
      }
      onMessage(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      if (kDebugMode) {
        print('onResume: {notification: ${event.notification}, data: ${event.data}}');
      }
      onMessageOpenedApp(event);
    });
  }

  //Channel Creation
  void _createChannel() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
