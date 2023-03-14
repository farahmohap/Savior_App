import 'package:application/controllers/home_page_controllers/getdata.dart';
import 'package:application/views/mapp.dart';
import 'package:application/views/styles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart ' as lot;
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class DragHome extends StatefulWidget {
  const DragHome({super.key});

  @override
  State<DragHome> createState() => _DragHomeState();
}

class _DragHomeState extends State<DragHome> with TickerProviderStateMixin {
  late AnimationController _heartbeat;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    GetData.hrate(context);
  }

  @override
  void initState() {
    super.initState();
   // GetData.getData();

    // Future.delayed(Duration.zero, () {
    //   GetData.hrate(context);
    // });

    _heartbeat =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    if (_heartbeat.isAnimating) {
      // _bellController.stop();
      _heartbeat.reset();
    } else {
      _heartbeat.repeat();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _heartbeat.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DraggableHome(
      backgroundColor: Colors.white,
      centerTitle: true,
      alwaysShowLeadingAndAction: true,
      appBarColor: Style.darkblue.withOpacity(.8),
      leading: Icon(Icons.search),
      actions: [
        Image.asset(
          "images/notification.png",
          height: 35,
        ),
        Image.asset(
          "images/user.png",
          height: 35,
        ),
      ],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(217, 134, 182, 205).withOpacity(.6),
        onPressed: () {},
        child: IconButton(
            onPressed: () {}, icon: Image.asset("images/ambulance.png")),
      ),
      title: const Text("SAVIOR",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: Style.fontfamily,
          )),
      headerWidget: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "images/drowning.jpg",
              ),
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(250, 136, 173, 186).withOpacity(.5),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            "Welcome Back!",
                            style: TextStyle(
                                fontSize: 33,
                                fontFamily: Style.fontfamily,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const Text(
                          "How Can I Help You ? ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: Style.fontfamily,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]))),
      body: [
        Container(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          alignment: Alignment.topLeft,
          child: const Text("Team Members",
              style: TextStyle(
                color: Style.darkblue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: Style.fontfamily,
              )),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Row(
              children: const [
                SizedBox(
                  height: 60,
                ),
                //for (int i = 0; i < 10; i++)
                // CircleAvatar(
                //   backgroundImage: AssetImage("GetData.data['userimage']),
                //   backgroundColor: Colors.transparent,
                // ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/tareqqq.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/farah.jpeg"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/salma.jpeg"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/abdalah.jpeg"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/yaso.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/woman2.png"),
                  backgroundColor: Colors.transparent,
                ),

                CircleAvatar(
                  backgroundImage: AssetImage("images/user.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/woman.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/man.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/man2.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/woman2.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/man.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/user.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/woman.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/man.png"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("images/man2.png"),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: ButtonStyle(
                alignment: Alignment.centerRight,
              ),
              child: Text("More Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Style.darkblue,
                      fontFamily: Style.fontfamily,
                      decoration: TextDecoration.underline)),
              onPressed: () {},
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(
            left: 30,
          ),
          alignment: Alignment.topLeft,
          child: Text("Discover Band ",
              style: TextStyle(
                color: Style.darkblue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: Style.fontfamily,
              )),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ImageSlideshow(
              height: size.height * .25,
              indicatorBackgroundColor: Colors.lightBlue,
              indicatorColor: Colors.white,
              isLoop: true,
              width: size.width * .95,
              children: [
                Image.asset(
                  "images/band1.png",
                ),
                Image.asset("images/girls.jpg"),
                Image.asset("images/band3.jpg"),
              ],
            )),
        Divider(
          color: Color.fromARGB(255, 218, 169, 165),
          thickness: 1,
          indent: 5,
          endIndent: 5,
        ),
        Text(
          "Services",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 247, 66, 66)),
        ),
        Container(
          margin: EdgeInsets.all(7),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            IconButton(
                              tooltip: "Map",
                              splashRadius: 50,
                              iconSize: 130,
                              onPressed: () {
                                Get.to(Mapp());
                              },
                              icon: Image.asset(
                                'images/map.png',
                              ),
                            ),
                            Text(
                              "Map",
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 44, 97),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            IconButton(
                                tooltip: "Devices",
                                splashRadius: 50,
                                iconSize: 130,
                                onPressed: () {
                                 Get.to(DragHome());
                                },
                                icon: Image.asset("images/connection.png")),
                            const Text(
                              "Devices",
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 44, 97),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            IconButton(
                              tooltip: "Data History",
                              splashRadius: 50,
                              iconSize: 130,
                              onPressed: () {
                               Get.to(DragHome());
                              },
                              icon: lot.Lottie.asset('assests/history.json',
                                  controller: _heartbeat),
                            ),
                            Text(
                              " History",
                              style: TextStyle(
                                color: Style.darkblue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            IconButton(
                                tooltip: "Statistics",
                                splashRadius: 50,
                                iconSize: 130,
                                onPressed: () {
                                  Get.to(DragHome());
                                },
                                icon: Image.asset("images/statistics.png")),
                            Text(
                              "Statistics",
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 44, 97),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: [
                            IconButton(
                              tooltip: "Settings",
                              splashRadius: 50,
                              iconSize: 130,
                              onPressed: () {
                                GetData.hrate(context);
                               
                              },
                              icon: lot.Lottie.asset(
                                'assests/settings.json',
                                controller: _heartbeat,
                              ),
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: Style.darkblue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
