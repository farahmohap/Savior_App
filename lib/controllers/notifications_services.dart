import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings("drowning");
  void initialiseNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void senfNotifivation() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channel id_1", "channel name",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            sound: RawResourceAndroidNotificationSound('emergency'));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(
        0, "Emergency", "HeeeeeeeeeeeeeeeLpppp", notificationDetails);
  }
}
