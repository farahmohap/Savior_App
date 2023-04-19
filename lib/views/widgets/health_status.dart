
import 'package:application/views/styles.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:lottie/lottie.dart ' as lot;
import 'package:flutter/material.dart';

class HealthStatus extends StatefulWidget  {
  var bpm;
  var spo2;
  

  HealthStatus(
      {
      required bpm,
      required spo2,
     }) {
    this.bpm = bpm;
    this.spo2 = spo2;
   
  }

  @override
  State<HealthStatus> createState() => _HealthStatusState();
}

class _HealthStatusState extends State<HealthStatus> with TickerProviderStateMixin {
  late AnimationController _heartbeat;

  @override
  void initState() {
    super.initState();
    _heartbeat =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    if (_heartbeat.isAnimating) {
      // _bellController.stop();
      _heartbeat.reset();
    } else {
      _heartbeat.repeat();
    }
  }

  void dispose() {
    _heartbeat.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // for (int i = 0; i < GetData.data.length; i++)
                          Row(
                            children: [
                              Expanded(
                                child: AnimatedContainer(
                                  margin: EdgeInsets.only(top: 15),
                                  height: 170,
                                  duration: Duration(milliseconds: 50),
                                  child: InkWell(
                                    radius: 200,
                                    child: Card(
                                      //color: Color.fromARGB(255, 247, 208, 67),
                                      color: Color.fromARGB(255, 88, 158, 255),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Text(
                                                this.widget.bpm,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                "bpm ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            splashRadius: 50,
                                            iconSize: 72,
                                            onPressed: () {},
                                            icon: lot.Lottie.asset(
                                                'assests/heart.json',
                                                controller: _heartbeat,
                                                height: 100,
                                                fit: BoxFit.cover),
                                          ),
                                          const Text(
                                            "Heart Rate",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        AwesomeNotifications()
                                            .requestPermissionToSendNotifications();
                                        AwesomeNotifications()
                                            .createNotification(
                                                content: NotificationContent(
                                          id: 1,
                                          channelKey: "Basic Key",
                                          title: "حاله طوارئ ج",
                                          body: "غرييييييييييقققق",
                                        ));
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedContainer(
                                  margin: EdgeInsets.only(top: 15),
                                  height: 170,
                                  duration: Duration(milliseconds: 50),
                                  child: InkWell(
                                    radius: 200,
                                    child: Card(
                                      color: Style.darkblue,
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Text(
                                                this.widget.spo2,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                "% ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            splashRadius: 50,
                                            iconSize: 65,
                                            onPressed: () {},
                                            icon: lot.Lottie.asset(
                                                'assests/oxygen.json',
                                                controller: _heartbeat,
                                                width: 150),
                                          ),
                                          const Text(
                                            "Oxygen Saturation ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AnimatedContainer(
                                  margin: EdgeInsets.only(top: 15),
                                  height: 170,
                                  duration: Duration(milliseconds: 50),
                                  child: InkWell(
                                    radius: 200,
                                    child: Card(
                                      color: Color.fromARGB(255, 247, 208, 67),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(children: [
                                          Row(
                                            children: const [
                                              Text(
                                                "30",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                " m ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            splashRadius: 50,
                                            iconSize: 72,
                                            onPressed: () {},
                                            icon: lot.Lottie.asset(
                                                'assests/distance.json',
                                                controller: _heartbeat,
                                                height: 100,
                                                fit: BoxFit.cover),
                                          ),
                                          Text(
                                            "Distance",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
  }
}