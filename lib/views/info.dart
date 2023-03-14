import 'dart:collection';
import 'package:application/controllers/home_page_controllers/getdata.dart';
import 'package:application/views/dragabble.dart';
import 'package:application/views/mapp.dart';
import 'package:application/views/reusable.dart';
import 'package:application/views/styles.dart';
import 'package:lottie/lottie.dart ' as lot;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with TickerProviderStateMixin {
  var myMarker = HashSet<Marker>();
  int chartIndex = 0;

  late AnimationController _heartbeat;
  @override
  void initState() {
    super.initState();
    // GetData.getData();
    Location.getMapp(context);

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        toolbarHeight: 160,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: Container(child: Location.getMapp(context)),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Nav.getNav(context, 1),
      body: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 30, right: 10, left: 10),
              width: double.infinity,
              child: Column(
                children: [
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
                      child: Column(
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
                                            children: const [
                                              Text(
                                                "77 ",
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
                                      setState(() {});
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
                                            children: const [
                                              Text(
                                                "95",
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
                      ),
                    ),
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
                        child: Column(
                          children: [
                            Card(
                              color: Color.fromARGB(255, 205, 211, 222),
                              child: ListTile(
                                leading: Image.asset(
                                  "images/headband.png",
                                  width: 35,
                                ),
                                title: Text(
                                  "ID",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "11F455d",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Color.fromARGB(255, 181, 199, 235),
                              child: ListTile(
                                leading: Image.asset(
                                  "images/headbandUser.png",
                                  width: 35,
                                ),
                                title: Text(
                                  "Username",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Farah",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Color.fromARGB(255, 142, 176, 243),
                              child: ListTile(
                                leading: Image.asset(
                                  "images/agerange.png",
                                  width: 35,
                                ),
                                title: Text(
                                  "Age",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "10",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ))),
    );
  }
}
