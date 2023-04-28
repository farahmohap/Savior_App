import 'dart:collection';
import 'package:application/controllers/infoController.dart';
import 'package:application/models/getdata.dart';
import 'package:application/views/reusable.dart';
import 'package:application/views/styles.dart';
import 'package:application/views/widgets/band_info.dart';
import 'package:application/views/widgets/custom_navbar.dart';
import 'package:application/views/widgets/health_status.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart ' as lot;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/location.dart';

class Info extends StatefulWidget {
  var bpm;
  var spo2;
  var user;
  var age;
  var phone;

  Info(
      {super.key,
      required bpm,
      required spo2,
      required user,
      required age,
      required phone}) {
    this.bpm = bpm;
    this.spo2 = spo2;
    this.user = user;
    this.age = age;
    this.phone = phone;
  }

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    GetData.getData();
    Location.getMapp(context);
    GetData.notifi();
  }

  @override
  Widget build(BuildContext context) {
        final databaseReference = FirebaseDatabase.instance.ref().child('ESP32-v1');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          toolbarHeight: 160,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: Container(child: GetLocation()),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Nav.getNav(context, 1),
        body: StreamBuilder<DatabaseEvent>(
            stream: databaseReference.onValue,
            builder: (context,  AsyncSnapshot snapshot) {
               final data = Map<String, dynamic>.from(snapshot.data.snapshot.value);
          final bpm = data['heartrate'];
              return SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          MaterialButton(
                              child: Text("Emergency"),
                              onPressed: () {
                                AwesomeNotifications().createNotification(
                                    content: NotificationContent(
                                  id: 1,
                                  channelKey: "Basic Key",
                                  title: "حاله طوارئ ج",
                                  body: "غرييييييييييقققق",
                                ));
                              }),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Health Status',
                                  labelStyle: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 221, 26, 26)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: HealthStatus(
                                  
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 120),
                            child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Band Information',
                                  labelStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 30, 29, 40)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: BandInfo(
                                  user: widget.user,
                                  age: widget.age,
                                  phone: widget.phone,
                                )),
                          ),
                        ],
                      )));
            }));
  }
}
