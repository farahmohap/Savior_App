import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetData {
  // ignore: prefer_typing_uninitialized_variables
  static String? latitiude;
  // ignore: prefer_typing_uninitialized_variables
  static String? longitude;
  static String? bpm;
  static String? spo2;
  static String? name;
  static String? age;
  static String? phone;

  static getData() {
    DatabaseReference locationRef = FirebaseDatabase.instance.ref('ESP32-v1');
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('ESP32-v1/userInfo');
    
    locationRef.onValue.listen((DatabaseEvent event) {
      latitiude = event.snapshot.child("lat").value.toString();
      longitude = event.snapshot.child("lon").value.toString();
      bpm = event.snapshot.child("heartrate").value.toString();
      spo2 = event.snapshot.child("spo2").value.toString();
      //time = event.snapshot.child('time').value;   
      
    });
    databaseReference.onValue.listen((event) {
        name = event.snapshot.child('username').value.toString();
        age = event.snapshot.child('age').value.toString();
        phone = event.snapshot.child('phoneNumber').value.toString();
      });
  }

  static notifi() {
    if (int.parse(bpm!) < 200) {
      return AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 1,
        channelKey: "Basic Key",
        title: "حاله طوارئ ج",
        body: "غرييييييييييقققق",
        
      ));
    }
  }
}
