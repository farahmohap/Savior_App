import 'dart:io';
import 'dart:math';
import 'package:application/views/settings/change_password.dart';
import 'package:application/views/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user_Id;
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

    setState(() {
      data.add(response.data());
      data_name = data[0]['name'];
      profile_url = data[0]['image'];

      if (data.isEmpty) {
        name.text = "Loading";
        phone.text = "Loading";
        age.text = "Loading";
        national_id.text = "Loading";
        adress.text = "Loading";
      } else {
        name.text = data[0]['name'];
        phone.text = data[0]['phone'];
        age.text = data[0]['age'];
        national_id.text = data[0]['national_id'];
        adress.text = data[0]['adress'];
      }
      print(data);
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

  upload_picture() async {
    var imgpicked = await imagepacker.pickImage(source: ImageSource.gallery);
    if (imgpicked != null) {
      image = File(imgpicked.path);
      var image_name = path.basename(image.path);
      var random = Random().nextInt(1000000);
      var new_name_image = "$image_name$random";
      var firebaseStorage =
          FirebaseStorage.instance.ref("images/$new_name_image");
      await firebaseStorage.putFile(image);
      var image_url = await firebaseStorage.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user_Id)
          .update({"image": image_url}).then((value) {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Profile Picture Updated',
          btnOkOnPress: () {
            Navigator.canPop(context);
          },
        )..show();
      });
      setState(() {
        profile_url = image_url;
      });
      print("Your Image:$image_name");
      print("Your Image URL:$image_url");
    } else {
      print("Choose Image");
    }
  }

  //FirebaseUser user = await FirebaseAuth.instance.currentUser!();
  change_password(String password) async {
    //Create an instance of the current user.
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    //Pass in the password to updatePassword.
    user?.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Profile Settings".tr),
        backgroundColor: Style.darkblue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Color.fromARGB(149, 240, 240, 243),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  child: Column(children: [
                    ListTile(
                      onTap: () {
                        Get.to(Change_Password());
                      },
                      leading: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Change Password",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Icon(
                          Icons.arrow_circle_right,
                          color: Color.fromARGB(255, 138, 136, 136),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          upload_picture();
                        });
                      },
                      leading: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.image,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Change Profile Photo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Icon(
                          Icons.arrow_circle_right,
                          color: Color.fromARGB(255, 138, 136, 136),
                        ),
                      ),
                    ),
                  ])),
              Container(
                margin: EdgeInsets.all(10),
                child: InputDecorator(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Update Information',
                      labelStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 221, 26, 26)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  "Username",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: name,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                )),
                          ),
                          Card(
                            child: ListTile(
                                leading: Icon(Icons.phone),
                                title: Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: phone,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                )),
                          ),
                          Card(
                            child: ListTile(
                                leading: Icon(Icons.mode_edit),
                                title: Text(
                                  "Age",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: age,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                )),
                          ),
                          Card(
                            child: ListTile(
                                leading: Icon(Icons.indeterminate_check_box),
                                title: Text(
                                  "N-ID",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: national_id,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 120,
                            child: MaterialButton(
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
                                ).show();
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25),
                              ),
                              minWidth: 400,
                              color: Color.fromARGB(255, 215, 12, 12),
                              shape: const StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
