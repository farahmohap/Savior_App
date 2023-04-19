import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  var user_Id;
  // ignore: non_constant_identifier_names
  var data_name;
  var data_phone;
  var data_age;
  var data_id;
  Map data_user = {};
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
    setState(() {
      data.add(response.data());
      if (data.isEmpty || data == null) {
        name.text = "Loading";
        phone.text = "Loading";
        age.text = "Loading";
        national_id.text = "Loading";
        email.text = "Loading";
        adress.text = "Loading";
      } else {
        name.text = data[0]['name'];
        phone.text = data[0]['phone'];
        age.text = data[0]['age'];
        national_id.text = data[0]['national_id'];
        email.text = data[0]['email'];
        adress.text = data[0]['adress'];
      }
    });
  }

  update_data(id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    collectionReference.doc(id).update({
      "age": age.text,
      "name": name.text,
      "national_id": national_id.text,
      "phone": phone.text,
    }).then((value) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Profile Data Updated',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      )..show();
    });
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
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Form(
                    child: Column(
                  children: [
                    const SizedBox(height: 0),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 94, 142, 181)),
                      height: 50,
                      width: 200,
                      child: Center(
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 43, 32, 32)),
                      controller: name,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          icon: new Image.asset(
                            "assets/man.png",
                            width: 40,
                            height: 50,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 3)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 12, 12, 12),
                                  width: 3)),
                          hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: new Image.asset(
                            "assets/phone.png",
                            width: 40,
                            height: 50,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 3)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 12, 12, 12),
                                  width: 3)),
                          hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: age,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: new Image.asset(
                            "assets/age.png",
                            width: 40,
                            height: 50,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 3)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 12, 12, 12),
                                  width: 3)),
                          hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black))),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: adress,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: new Image.asset(
                            "assets/location.png",
                            width: 40,
                            height: 50,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 3)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 12, 12, 12),
                                  width: 3)),
                          hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black))),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: national_id,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: new Image.asset(
                            "assets/id.png",
                            width: 40,
                            height: 50,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  width: 3)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 12, 12, 12),
                                  width: 3)),
                          hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black))),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.rightSlide,
                          title: 'Are You Sure To Update Your Data ?',
                          btnCancelOnPress: () {
                            Navigator.pop(context);
                          },
                          btnOkOnPress: () {
                            update_data(user_Id);
                          },
                        )..show();
                      },
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      minWidth: 400,
                      color: const Color.fromARGB(255, 94, 142, 181),
                      shape: const StadiumBorder(),
                    ),
                  ],
                )),
              ),
            ),
          ),
        )));
  }
}
