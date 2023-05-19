import 'package:application/controllers/emergencyCondition.dart';
import 'package:application/views/reusable.dart';
import 'package:application/views/styles.dart';
import 'package:application/views/widgets/connect_user.dart';
import 'package:application/views/widgets/custom_navbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  var code_device = new TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      scrollable: true,
                      content: Column(
                        children: [
                          SizedBox(height: 0),
                          Text(
                            'Add New Device',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: code_device,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 7, 7, 7),
                                        width: 3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 12, 12, 12),
                                        width: 3)),
                                hintText: "Code of the Device",
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black))),
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            onPressed: () async {
                              Map<String, dynamic> devices = {
                                'code': code_device.text,
                                'status': 'Off'
                              };
                              ref
                                  .child('Devices')
                                  .push()
                                  .set(devices)
                                  .then((value) {
                                return AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'New Devices Added',
                                  btnOkOnPress: () {
                                    Navigator.pop(context);
                                  },
                                )..show();
                              });
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            minWidth: 400,
                            color: Color.fromARGB(255, 94, 142, 181),
                          ),
                        ],
                      ));
                });
          }),
          child: Icon(Icons.add),
        ),
        key: ConnectUser.scaffoldKey,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            // Image.asset(
            //   "images/notification.png",
            //   height: 35,
            // ),
            Image.asset(
              "images/user.png",
              height: 35,
            )
          ],
          //leading: Icon(Icons.search),
          backgroundColor: Style.darkblue,
          title: Text("Devices".tr),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Nav.getNav(context, 2),
        body: SafeArea(
            bottom: false,
            child: StreamBuilder<DatabaseEvent>(
                stream: EmergencyCondition.infoRef.onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final data =
                        Map<String, dynamic>.from(snapshot.data.snapshot.value);
                    double lat = data['lat'];
                    double long = data['lon'];
                    var bpm = data['heartrate'];
                    var spo2 = data["spo2"];
                    var time = data["time"];
              //       EmergencyCondition.EmergencyNotification(bpm, spo2);
              // EmergencyCondition.ConstatntTimeNotification(time);
              // EmergencyCondition.DistanceNotification(lat, long);
              // EmergencyCondition.NoResponseData(bpm, spo2);
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 228, 231, 232),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: FirebaseAnimatedList(
                              shrinkWrap: true,
                              query: ConnectUser.ref,
                              itemBuilder: ((context, snapshot, animation,
                                      index) =>
                                  Card(
                                    color: Color.fromARGB(255, 192, 211, 237),
                                    child: ListTile(
                                      leading:
                                          ('${snapshot.child('status').value.toString()}' ==
                                                  "on")
                                              ? Icon(Icons.check)
                                              : Icon(Icons.not_interested),

                                      // Icon(Icons.connect_without_contact),
                                      title: Text("Device Number $index"),
                                      subtitle: Column(children: [
                                        Text(
                                            "Code :  ${snapshot.child('code').value.toString()}"),
                                        Text(
                                            "Status : ${snapshot.child('status').value.toString()}")
                                      ]),
                                      trailing: SizedBox(
                                        width: 78,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.green,
                                              child: IconButton(
                                                iconSize: 15,
                                                icon: Icon(
                                                  Icons
                                                      .app_registration_rounded,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  ConnectUser.getDialog(
                                                      context, snapshot, index);

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            IconButton(
                                              iconSize: 30,
                                              icon: Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                ConnectUser.ref
                                                    .child(
                                                        snapshot.key.toString())
                                                    .remove();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                })));
  }
}
