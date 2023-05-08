import 'package:application/views/features/info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings("drowning");

  static Future onDidReceiveNotificationResponse( NotificationResponse payload) async {
    if (payload == 'Show') {
      Get.to(Info());
      print(payload);
    }
  }

  void initialiseNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void senfNotifivation() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channel id_1", "channel name",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableLights: true,
            //autoCancel: true,
            timeoutAfter: 9000,
            actions: [
              AndroidNotificationAction(
                "11",
                "Show",
               // showsUserInterface: true,
              ),
            ],
            sound: RawResourceAndroidNotificationSound('emergency'));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(0, "Emergency Case",
        "Hurrry Up , Someone is in Danger !!", notificationDetails);
  }

  // void secheduleNotification() async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       const AndroidNotificationDetails("channel_id_2", "channel name",
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           playSound: true,
  //           enableLights: true,
  //           autoCancel: true,
  //           timeoutAfter: 9000,
  //           sound: RawResourceAndroidNotificationSound('emergency'));
  //   NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);

  //   await _flutterLocalNotificationsPlugin.periodicallyShow(0, "Emergency",
  //       "Helpp", RepeatInterval.everyMinute, notificationDetails);
  // }

  void stopNotification() async {
    _flutterLocalNotificationsPlugin.cancelAll();
  }
}
