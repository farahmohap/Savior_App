import 'package:application/controllers/notifications_services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:path/path.dart';

class EmergencyCondition {
  static DatabaseReference infoRef = FirebaseDatabase.instance.ref('ESP32-v1');
  static NotificationsServices notificationsServices = NotificationsServices();

  static EmergencyNotification(bpm, spo2) {
    if (bpm > 100 || bpm <= 60 || spo2 < 90) {
      notificationsServices.senfNotifivation();
    }
  }

  // static Awesome(bpm, spo2) {
  //   AwesomeNotifications().requestPermissionToSendNotifications();
  //   if (bpm > 100 || bpm <= 60 || spo2 < 90) {
  //     AwesomeNotifications().createNotification(
  //         content:
  //          NotificationContent(id: 0,
  //           channelKey: 'channelKey',
  //           title: 'Test',body: 'Testtt'));
  //   }
  // }

  // static void SecheduleNotification(bpm, spo2) {
  //   if (bpm > 100 || bpm <= 60 || spo2 < 90) {
  //     notificationsServices.secheduleNotification();
  //   }
  //   else{
  //      notificationsServices.stopNotification();
  //   }
  // }

  // static void StopNotification(bpm, spo2) {
  //   notificationsServices.stopNotification();
  // }
}
