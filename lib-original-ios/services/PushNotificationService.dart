import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'SlackNotificationService.dart';
import 'package:flutter/cupertino.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackgroundHandler ${message.messageId}');
    SlackNotificationService.sendSlackMessage(message.toString());
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onMessageHandler ${message.messageId}');
    SlackNotificationService.sendSlackMessage(message.toString());
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenAppHandler ${message.messageId}');
    SlackNotificationService.sendSlackMessage(message.toString());
  }

  static Future initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    //var box = await Hive.openBox('app_data');
    token = await FirebaseMessaging.instance.getToken();
    //box.put('push_token', token);
    //SlackNotificationService.sendSlackMessage(token!);
    print('Token $token');

    /*NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    } */

    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

  }

}