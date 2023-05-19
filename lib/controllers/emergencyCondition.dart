import 'package:application/controllers/notifications_services.dart';
import 'package:application/views/features/info.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'dart:math' show cos, sqrt, asin;
import 'dart:core';

class EmergencyCondition {
  static DatabaseReference infoRef = FirebaseDatabase.instance.ref('ESP32-v1');
  static NotificationsServices notificationsServices = NotificationsServices();
  static LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }

  static int calculateDistance(lat2, long2) {
    // var lat1 = currentLocation!.latitude;
    // var long1 = currentLocation!.longitude!;
    var lat1 = 30.56302530323952;
    var long1 = 31.008665684335686;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((long2 - long1) * p)) / 2;
    return (12742 * asin(sqrt(a)) * 1000).ceil();
  }

  static EmergencyNotification(bpm, spo2) {
    if ((bpm > 90 || bpm <= 60) || (spo2 <90 || spo2 > 100)) {
      notificationsServices.EmergencyNotification();
    }
  }

  static ConstatntTimeNotification(BandTime) {
    var timeNow = DateTime.now();
    var timeNowInMillisecond = timeNow.millisecondsSinceEpoch;
    if (timeNowInMillisecond - BandTime >= 10000) {
      notificationsServices.DrowningNotification();
      print(timeNow);
    }
  }

  static NoResponseData(bpm, spo2) {
    if (bpm == -999 || spo2 == -999) {
      notificationsServices.NoResponseDataNotification();
    }
  }

  static DistanceNotification(lat, long) {
    int dist = calculateDistance(lat, long);
    if (dist > 5) {
      notificationsServices.DistanceNotification();
    } else {
      print("TT");
    }
  }

  // static void StopNotificationn(bpm, spo2) {
  //   if (bpm > 100 || bpm <= 60 || spo2 < 90) {
  //     notificationsServices.stopNotification();
  //   }
  // }

  // static void StopNotification() {
  //   notificationsServices.stopNotification();
  // }

  // static Awesome(bpm, spo2) {
  //   AwesomeNotifications().requestPermissionToSendNotifications();
  //   if (bpm > 100 || bpm <= 60 || spo2 < 90) {
  //     AwesomeNotifications().createNotification(
  //         content: NotificationContent(
  //           id: 1,
  //           channelKey: 'channelKey',
  //           title: 'Test',
  //           body: 'Testtt',
  //         ),
  //         actionButtons: [
  //           NotificationActionButton(
  //             key: "open",
  //             label: "Open File",
  //           ),
  //           NotificationActionButton(
  //             key: "delete",
  //             label: "Delete File",
  //           )
  //         ]);
  //   }
//     AwesomeNotifications().setListeners(
//     onActionReceivedMethod: (ReceivedAction receivedAction){
//       return  NotificationsServices.onActionReceivedMethod(context);

//     },
// );

  // static void SecheduleNotification(bpm, spo2) {
  //   if (bpm > 100 || bpm <= 60 || spo2 < 90) {
  //     notificationsServices.secheduleNotification();
  //   }
  //   else{
  //      notificationsServices.stopNotification();
  //   }
  // }

}
