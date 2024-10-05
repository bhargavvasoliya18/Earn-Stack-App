import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool isNotificationArrived = false;
class FirebaseMessagesHelper{
  static var pastMessage = null;

  static String eventDate = '';
  static bool isOnTapEventNotification = false;
  static bool isNeedToFireLocalNotification = true;

  static initFirebaseMessage(BuildContext context) async {

    NotificationSettings appleNotificationSettings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.setAutoInitEnabled(true);
    _firebaseMessaging.getToken().then((value) {
      print("#TOKEN $value");
    });

    FirebaseMessaging.onMessage.listen((event) { });
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print("onMessage :: ${message.data.toString()}");
        isNotificationArrived = true;
        handleNotification(message, isNeedToFireLocalNotification,methodName: 'onMessage');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message)async {
      print("onOpenMessage :: ${message.data.toString()}");
      handleNotificationMessage(context, message,"onMessageOpenedApp");
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onBackgroundMessage :: ${message.data.toString()}");
      handleNotificationMessage(context, message,"onBackgroundMessage");
    });
    getInitialMessages(context);
  }

  static getInitialMessages(BuildContext context) async {
   var message = await FirebaseMessaging.instance.getInitialMessage();
   print("initial message data is ${message?.data}");
   handleNotificationMessage(context, message, "getInitialMessage");
  }

  static handleNotification(RemoteMessage message, bool fireLocalNotification,{String methodName = '',String notificationId = ''}){
    pastMessage = message;
    if (Platform.isIOS == false && message.notification != null && fireLocalNotification) {
      print("message data is ${message.data}");
        sendLocalNotification("Check title", "Test notification",1);
    }
  }

  static handleNotificationMessage(BuildContext context, RemoteMessage? message , String messageType ) async {
      if (message != null) {
        isNotificationArrived = true;
        handleNotification(message, false,methodName: messageType);
      }
  }

  static sendLocalNotification(String title,String message,int id,{String methodName = '',String notificationId = ''}){
      if(title.isNotEmpty && message.isNotEmpty) {
        var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
      flutterLocalNotificationsPlugin.show(
          id,
          title,
          message,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'post_channel',
              'post_channel',
              importance: Importance.high,
              priority: Priority.high,
              icon: initializationSettingsAndroid.defaultIcon,
            ),
          ));
      }
    }
}