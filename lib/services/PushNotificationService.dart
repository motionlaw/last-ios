import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';


String? selectedNotificationPayload;

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackground Hanlder : ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future _onMessageHanlder(RemoteMessage message) async {
    print('onMessage Hanlder : ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp Hanlder : ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('token : ${token}');

    /* Handlers */
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHanlder);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

  }

  static closeStreams() {
    _messageStream.close();
  }
}