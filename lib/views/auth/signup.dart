import 'package:application/views/auth/signin.dart';
import 'package:application/views/widgets/waves.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../../controllers/signup_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ClipPath(
                          clipper: WaveShape(),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                color: Colors.blue.withOpacity(.6),
                              ),
                            ],
                          )),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: name,
                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Full Name'.tr,
                                      // hintText: 'Email Or Phone Number',
                                    )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: email,

                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email Address'.tr,
                                      //hintText: 'Password',
                                    )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: phone,
                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Phone Number',
                                      //hintText: 'Password',
                                    )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: password,
                                    obscureText: true,
                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password'.tr,
                                    )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: confirm_password,
                                    obscureText: true,
                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Confirm Password'.tr,
                                      //hintText: 'Password',
                                    )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: adress,
                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Address',
                                      //hintText: 'Password',
                                    )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: national_id,
                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'N_ID',
                                      //hintText: 'Password',
                                    )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: TextField(
                                    controller: age,

                                    //maxLength: 70,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Age',
                                      //hintText: 'Password',
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                minWidth: 170,
                                textColor: Colors.black,
                                color: Color.fromARGB(255, 247, 208, 67),
                                child: Text(
                                  'Sign Up'.tr,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  data_password = password.text;
                                  data_confirm_password = confirm_password.text;
                                  data_name = name.text;
                                  data_phone = phone.text;
                                  data_email = email.text;
                                  data_age = age.text;
                                  data_adress = adress.text;
                                  data_national_id = national_id.text;
                                  print(data_email);
                                  print(data_password);
                                  print(data_confirm_password);
                                  print(data_name);
                                  print(data_phone);
                                  print(data_age);
                                  print(data_national_id);
                                  if (data_confirm_password == data_password) {
                                    try {
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: data_email,
                                                  password: data_password);
                                      User? user = userCredential.user;
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user?.uid)
                                          .set({
                                        "name": data_name,
                                        "phone": data_phone,
                                        "age": data_age,
                                        "national_id": data_national_id,
                                        "adress": data_adress
                                      });
                                      Navigator.of(context)
                                          .pushReplacementNamed("Home");
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        print('The Password is very weak');
                                      } else if (e.code ==
                                          'email-aleady-in-use') {
                                        print(
                                            'The account is already exits for that email');
                                      }
                                    }
                                  } else {
                                    print("Password Not Match");
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already Have Account?".tr,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    //  textAlign: TextAlign.right,
                                  ),
                                  Builder(builder: (context) {
                                    return TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignIn()));
                                        },
                                        child: Text(
                                          "Sign In".tr,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          // textAlign: TextAlign.left,
                                        ));
                                  })
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Waves()
              ],
            ),
          )),
    );
  }
}
