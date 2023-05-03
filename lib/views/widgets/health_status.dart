import 'package:application/controllers/notifications_services.dart';
import 'package:application/models/getdata.dart';
import 'package:application/views/styles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart ' as lot;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;
import 'dart:core';

class HealthStatus extends StatefulWidget {
  var bpm;
  var spo2;

  // HealthStatus({
  //   required bpm,
  //   required spo2,
  // }) {
  //   this.bpm = bpm;
  //   this.spo2 = spo2;
  // }

  @override
  State<HealthStatus> createState() => _HealthStatusState();
}

class _HealthStatusState extends State<HealthStatus>
    with TickerProviderStateMixin {
  late AnimationController _heartbeat;
  DatabaseReference infoRef = FirebaseDatabase.instance.ref('ESP32-v1');
  late LocationData currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }

  int calculateDistance(lat2, long2) {
    var lat1 = currentLocation.latitude;
    var long1 = currentLocation.longitude;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1! * p) * c(lat2 * p) * (1 - c((long2 - long1) * p)) / 2;
    return (12742 * asin(sqrt(a)) * 1000).ceil();
  }

  NotificationsServices notificationsServices = NotificationsServices();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _heartbeat =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    if (_heartbeat.isAnimating) {
      // _bellController.stop();
      _heartbeat.reset();
    } else {
      _heartbeat.repeat();
    }
    notificationsServices.initialiseNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: infoRef.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = Map<String, dynamic>.from(snapshot.data.snapshot.value);
          final bpm = data['heartrate'];
          final spo2 = data['spo2'];
          final lat = data['latitude'];
          final long = data['longitude'];
          if (bpm < 70) {
            notificationsServices.senfNotifivation();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // for (int i = 0; i < GetData.data.length; i++)
              Row(
                children: [
                  Expanded(
                    child: healthStatusItem(
                        const Color.fromARGB(255, 88, 158, 255),
                        bpm.toString(),
                        "bpm ",
                        'assests/heart.json',
                        "Heart Rate".tr,
                        72,
                        19),
                  ),
                  Expanded(
                    child: healthStatusItem(
                        Style.darkblue,
                        spo2.toString(),
                        "%",
                        'assests/oxygen.json',
                        "Oxygen Saturation".tr,
                        70,
                        16),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: healthStatusItem(
                        Color.fromARGB(255, 247, 208, 67),
                        calculateDistance(lat, long).toString(),
                        " m ",
                        'assests/distance.json',
                        "Distance".tr,
                        60,
                        25),
                  ),
                ],
              ),
            ],
          );
        });
  }

  AnimatedContainer healthStatusItem(Color color, data, String measuringUnit,
      String iconPath, title, double iconsize, double fontsize) {
    return AnimatedContainer(
      margin: EdgeInsets.only(top: 15),
      height: 180,
      duration: Duration(milliseconds: 50),
      child: InkWell(
        radius: 200,
        child: Card(
          color: color,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    data,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    measuringUnit,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              IconButton(
                splashRadius: 50,
                iconSize: iconsize,
                onPressed: () {},
                icon: lot.Lottie.asset(iconPath,
                    controller: _heartbeat, height: 100, fit: BoxFit.cover),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontsize,
                ),
              )
            ]),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
