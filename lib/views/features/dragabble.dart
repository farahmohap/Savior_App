import 'package:application/controllers/emergencyCondition.dart';
import 'package:application/controllers/notifications_services.dart';
import 'package:application/views/settings/settings.dart';
import 'package:application/views/styles.dart';
import 'package:application/views/widgets/services_home.dart';
import 'package:application/views/widgets/team_members_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../widgets/carousel_slider.dart';

class DragHome extends StatefulWidget {
  const DragHome({super.key});

  @override
  State<DragHome> createState() => _DragHomeState();
}

class _DragHomeState extends State<DragHome> with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    int number = 122;
    return StreamBuilder<DatabaseEvent>(
        stream: EmergencyCondition.infoRef.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          final data = Map<String, dynamic>.from(snapshot.data.snapshot.value);
          final bpm = data['heartrate'];
          final spo2 = data['spo2'];

          EmergencyCondition.EmergencyNotification(bpm, spo2);
          return DraggableHome(
            headerExpandedHeight: .35,
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
              GestureDetector(
                onTap: () {
                  Get.to(Settingss());
                },
                child: Image.asset(
                  "images/user.png",
                  height: 35,
                ),
              ),
            ],
            floatingActionButton: FloatingActionButton(
              backgroundColor:
                  Color.fromARGB(217, 134, 182, 205).withOpacity(.6),
              onPressed: () {},
              child: IconButton(
                  onPressed: () async {
                    // ignore: deprecated_member_use
                    // UrlLauncher.launch("tel://$number");
                    FlutterPhoneDirectCaller.callNumber('$number');
                  },
                  icon: Image.asset("images/ambulance.png")),
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
                                child: Text(
                                  "Welcome Back!".tr,
                                  style: const TextStyle(
                                      fontSize: 33,
                                      fontFamily: Style.fontfamily,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                "How Can I Help You?".tr,
                                style: const TextStyle(
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
                child: Text("Team Members".tr,
                    style: const TextStyle(
                      color: Style.darkblue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: Style.fontfamily,
                    )),
              ),
              SizedBox(height: 40, child: TeamMembersView()),
              SizedBox(
                height: 20,
              ),
              //spacer

              Container(
                padding: EdgeInsets.only(
                  left: 30,
                ),
                alignment: Alignment.topLeft,
                child: Text("Discover Band".tr,
                    style: const TextStyle(
                      color: Style.darkblue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: Style.fontfamily,
                    )),
              ),
              CarouselSliderr(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      alignment: Alignment.centerRight,
                    ),
                    child: Text("MoreDetails".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Style.darkblue,
                            fontFamily: Style.fontfamily,
                            decoration: TextDecoration.underline)),
                    onPressed: () {},
                  ),
                ],
              ),
              const Divider(
                color: Color.fromARGB(255, 218, 169, 165),
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                "Services".tr,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 247, 66, 66)),
              ),
              ServicesHome(),
            ],
          );
        });
  }
}
