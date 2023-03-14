import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetData {
  static RxDouble? latitiude=0.0.obs;
  static RxDouble? longitude;
  static List bpm = [50, 40, 90, 10];
  static int? spo2;

   getData() {
    DatabaseReference locationRef = FirebaseDatabase.instance.ref('Location');
    locationRef.onValue.listen((DatabaseEvent event) {
      latitiude = double.parse(event.snapshot.child("Lat").value.toString()) as RxDouble?;
      longitude = double.parse(event.snapshot.child("Lon").value.toString()) as RxDouble;
    });
  }

  static hrate(context) {
    //await
    for (int i = 0; i < bpm.length; i++)
      if (bpm[i] <= 50) {
        return  showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("AAAAAAA"),
            );
          },
        );
      }
  }
}
