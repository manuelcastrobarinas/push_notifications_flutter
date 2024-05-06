import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationServices {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? token;
   
  static Future init() async { //init method to implement handlers and request
    await _firebaseMessaging.requestPermission( //get permissions of the user to recieve notifications
      alert   : true,
      badge   : true,
      sound   : true,
      carPlay : true,
      provisional   : true,
      announcement  : true,
      criticalAlert : true,
    );
    token = await _firebaseMessaging.getToken(); //set token to identify the device
    if (kDebugMode) {
      print("device token $token");
    }

    //handlers to get notifications when the app is open, in background or terminate
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);        
    FirebaseMessaging.onMessage.listen(_onMessageHandler);           
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);   
  }

  static Future _backgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print('onBackrground Handler ${message.messageId}');
    }
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print('on message Handler ${message.messageId}');
    }
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    if (kDebugMode) {
      print('on message open App Handler ${message.messageId}');
    }
  } 
}