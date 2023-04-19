import 'package:application/views/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Change_Password extends StatefulWidget {
  const Change_Password({super.key});

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  var old_password = TextEditingController();
  var new_password = TextEditingController();
  var confirm_new_password = TextEditingController();
  var email;
  var auth = FirebaseAuth.instance;
  var current_user = FirebaseAuth.instance.currentUser;
  change_password(email, old_password, new_password) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: old_password);
    await current_user?.reauthenticateWithCredential(cred).then((value) {
      current_user?.updatePassword(new_password).then((value) {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Password Changed',
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        )..show();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    email = user?.email;

    final user_id = user?.uid;
    print(user_id);
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password".tr),
        backgroundColor: Style.darkblue,
      ),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: SingleChildScrollView(
                  child: Form(
                child: Column(children: [
                  const SizedBox(height: 55),
                  Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                          color: Style.darkblue,
                          fontFamily: Style.fontfamily,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    style: TextStyle(color: Color.fromARGB(255, 43, 32, 32)),
                    controller: old_password,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Old Password",
                        enabledBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Color.fromARGB(255, 43, 32, 32)),
                    controller: new_password,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "New Password",
                        enabledBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color: Color.fromARGB(255, 43, 32, 32)),
                    controller: confirm_new_password,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Confirm New Password",
                        enabledBorder: const OutlineInputBorder(),
                        focusedBorder:
                            const OutlineInputBorder(borderSide: BorderSide()),
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (new_password.text == confirm_new_password.text) {
                        change_password(
                            email, old_password.text, new_password.text);
                      } else {
                        print('Password Not Match');
                      }

                      //
                    },
                    child: const Text(
                      'Change',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    minWidth: 400,
                    color: Color.fromARGB(255, 215, 12, 12),
                    shape: const StadiumBorder(),
                  ),
                ]),
              )),
            )),
      ),
    );
  }
}
