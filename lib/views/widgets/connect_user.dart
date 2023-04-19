import 'package:application/views/features/info.dart';
import 'package:application/views/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class ConnectUser {
  static var name = TextEditingController();
  static var phone = TextEditingController();
  static var age = TextEditingController();
  static void clear_textfield() {
    name.clear();
    phone.clear();
    age.clear();
  }

  static final ref = FirebaseDatabase.instance.ref('Devices');
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  static getDialog(context, snapshot, index) {
    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              elevation: 50,
              icon: Row(
                children: [
                  Icon(
                    Icons.app_registration_rounded,
                    color: Colors.green,
                    size: 50,
                  ),
                  Text(
                    'Register Form',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: Style.fontfamily,
                        color: Style.darkblue),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              scrollable: true,
              actions: [
                TextButton(
                    onPressed: () {
                      Map<String, dynamic> Add_person = {
                        'name': name.text,
                        'phone': phone.text,
                        'age': age.text
                      };
                      ref.child('${snapshot.key}/person').set(Add_person);

                      Map<String, dynamic> Status_Connect = {'status': 'On'};
                      ref
                          .child(snapshot.key.toString())
                          .update(Status_Connect)
                          .then((value) {
                        return AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'New Devices Conneected',
                          btnOkOnPress: () {
                            print("sdd");
                          },
                        )..show();
                      });
                      ;

                      clear_textfield();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Connect',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      clear_textfield();
                      Map<String, dynamic> Status_cancel = {'status': 'Off'};
                      ref.child(snapshot.key.toString()).update(Status_cancel);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              ],
              title: Column(children: [
                Text(
                  'To Connect with Device : $index',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: Style.fontfamily,
                      color: Colors.grey),
                ),
                Text(
                  'Fill This Form',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: Style.fontfamily,
                      color: Colors.grey),
                ),
              ]),
              content: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: Style.darkblue,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                          labelText: "Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 1)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: Style.darkblue,
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              )),
                          labelText: 'Phone',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 1)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: age,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: Style.darkblue,
                            child: Icon(
                              Icons.numbers,
                              color: Colors.white,
                            ),
                          ),
                          labelText: 'Age',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 1)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    ),
                  ],
                ),
              ),
            )));
  }
}
