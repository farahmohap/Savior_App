import 'package:application/views/features/info.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings("drowning");

   Future Responsee(NotificationResponse payload) async {
      print("HAaaa");
    }
  

  void initialiseNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: Responsee);
  }

// void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload: $payload');
//     }
// }

 

  void EmergencyNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channel id_0", "channel name",      
            fullScreenIntent: true,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableLights: true,
            //autoCancel: true,
            timeoutAfter: 9000,
            // actions: [
            //   AndroidNotificationAction(
            //     "11",
            //     "Show",
            //     // showsUserInterface: true,
            //   ),
            //   AndroidNotificationAction("12", "Cancel", cancelNotification: true
            //       // showsUserInterface: true,
            //       ),
            // ],
            sound: RawResourceAndroidNotificationSound('emergency'));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(0, "Emergency Case",
        "Hurrry Up , Someone is in Danger !!", notificationDetails);
  }
  void DrowningNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channel id_1", "channel name",      
            fullScreenIntent: true,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableLights: true,
            //autoCancel: true,
            timeoutAfter: 9000,          
            sound: RawResourceAndroidNotificationSound('emergency'));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(1, "Drowning Case",
        "Child is suffering from Hypoxia ,he is almost fainting", notificationDetails);
  }
  void NoResponseDataNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channel id_2", "channel name",
            
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableLights: true,
            //autoCancel: true,
            timeoutAfter: 9000,          
            sound: RawResourceAndroidNotificationSound('emergency'));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(2, "Warning",
        "Device Is Not Connected ", notificationDetails);
  }
   void DistanceNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channel id_3", "channel name",   
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableLights: true,
            //autoCancel: true,
            timeoutAfter: 9000,          
            sound: RawResourceAndroidNotificationSound('distt'));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(3, "Watch Out !",
        "Device is out Safe Zone  ", notificationDetails);
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
    _flutterLocalNotificationsPlugin.cancel(0);
  }
}
