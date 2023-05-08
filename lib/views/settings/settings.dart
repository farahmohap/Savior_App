import 'dart:io';
import 'dart:math';

import 'package:application/controllers/emergencyCondition.dart';
import 'package:application/views/reusable.dart';
import 'package:application/views/settings/profile.dart';
import 'package:application/views/styles.dart';
import 'package:application/views/widgets/changeLanguage.dart';
import 'package:application/views/widgets/custom_navbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import 'package:toggle_switch/toggle_switch.dart';

import '../../controllers/locale/locale_controller.dart';

class Settingss extends StatefulWidget {
  const Settingss({super.key});

  @override
  State<Settingss> createState() => _SettingssState();
}

class _SettingssState extends State<Settingss> {
  var user_Id;
  List data_user = [];
  var user_id;
  var data_name;
  var data_email;
  var new_password = TextEditingController();
  var profile_url;
  late File image;
  var imagepacker = ImagePicker();
  List data = [];
  var name = TextEditingController();
  var phone = TextEditingController();
  var age = TextEditingController();
  var national_id = TextEditingController();
  var email = TextEditingController();
  var adress = TextEditingController();

  get_data_user(id) async {
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(id);
    var response = await users.get();
    user_id = id;
    setState(() {
      data_user.add(response.data());
      data_name = data_user[0]['name'];
      data_email = data_user[0]['email'];
      profile_url = data_user[0]['image'];
    });
    print(data_user);
    print(user_id);
  }

  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user?.uid;
    print(userId);
    user_Id = userId;
    get_data_user(userId);
    print(user_Id);
    print(user?.email);
  }

  @override
  Widget build(BuildContext context) {
    MyLocaleController langcontroller = Get.find();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Settings".tr),
        backgroundColor: Style.darkblue,
      ),
      bottomNavigationBar: Nav.getNav(context, 3),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(149, 240, 240, 243),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder<DatabaseEvent>(
                stream: EmergencyCondition.infoRef.onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  final data =
                      Map<String, dynamic>.from(snapshot.data.snapshot.value);
                  final bpm = data['heartrate'];
                  final spo2 = data['spo2'];
                 EmergencyCondition.EmergencyNotification(bpm, spo2);
                  return Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(profile_url ??
                              "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data_name ?? "Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: size.width * .06, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            style: TextStyle(fontSize: 12),
                            "Common".tr,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      child: Column(children: [
                        ListTile(
                          leading: CircleAvatar(
                              radius: 18, child: Icon(Icons.language_sharp)),
                          title: Text("Language".tr),
                           trailing: 
                          ToggleSwitch(
                            minWidth: 35,
                            minHeight: 20,
                            fontSize: 10.0,
                            initialLabelIndex: 1,
                            activeBgColor: const [
                              Color.fromARGB(255, 216, 2, 2),
                            ],
                           
                            activeFgColor: Colors.white,
                            inactiveBgColor: Color.fromARGB(255, 196, 193, 193),
                            inactiveFgColor: Colors.grey[900],
                            totalSwitches: 2,
                            changeOnTap: true,
                            animate: true,
                            labels: const ['En', 'Ar'],
                            onToggle: (index) {
                              if (index == 0) {
                                setState(() {
                                  langcontroller.changeLanguage("en");
                                });
                              }
                              if (index == 1) {
                                setState(() {
                                  langcontroller.changeLanguage("ar");
                                });
                              }
                            },
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.dark_mode_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text("DarkMode".tr),
                          trailing: Switch(
                            value: true,
                            onChanged: ((value) {}),
                          ),
                        )
                      ]),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: size.width * .06, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            style: TextStyle(fontSize: 12),
                            "Account".tr,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration:const  BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(Profile());
                          },
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 18,
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                              ),
                            ),
                            title: Text("Profile Settings"),
                            trailing: IconButton(
                              onPressed: () {
                                Get.to(Profile());
                              },
                              icon: Icon(Icons.arrow_circle_right_outlined),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal.withOpacity(.5),
                            radius: 18,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.teal,
                            ),
                          ),
                          title: Text("Notifications".tr),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: size.width * .06, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            style: TextStyle(fontSize: 12),
                            "General".tr,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      child: Column(children: [
                        ListTile(
                          title: Text("Support"),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
                        ListTile(
                          title: Text("Policy"),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        )
                      ]),
                    ),
                     Container(
                       margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                       child: ListTile(
                            onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.rightSlide,
                                  title: 'Are You Sure To Exit ?',
                                  btnOkOnPress: () {
                                    SystemNavigator.pop();
                                  },
                                  btnCancelOnPress: () {
                                    Navigator.canPop(context);
                                  })
                                ..show();
                            },
                            
                            leading:const  CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                            ),
                            title: Text(
                              "Log Out",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                     ),
                        
                  ]);
                }),
          ),
        ),
      ),
    );
  }
}
