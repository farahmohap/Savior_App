import 'package:application/views/auth/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:flutter/widgets.dart';
import 'package:proste_bezier_curve/utils/type/index.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm_password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var age = TextEditingController();
  var adress = TextEditingController();
  var national_id = TextEditingController();
  var data_email;
  var data_name;
  var data_phone;
  var data_age;
  var data_national_id;
  var data_password;
  var data_confirm_password;
  var data_adress;

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
                                "Sign Up",
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
                                      labelText: 'Full Name',
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
                                      labelText: 'Email',
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
                                      labelText: 'Password',
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
                                      labelText: 'Confirm Password',
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
                                  'Sign Up',
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
                                    "Already Have Account?",
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
                                          "Sign In",
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
                Container(
                    margin: const EdgeInsets.only(top: 630, bottom: 0),

                    // alignment: Alignment.centerRight,
                    child: WaveWidget(
                      //user Stack() widget to overlap content and waves
                      config: CustomConfig(
                        colors: [
                          Color.fromARGB(255, 190, 196, 255).withOpacity(0.3),
                          Color.fromARGB(255, 15, 56, 110).withOpacity(.4),
                          Color.fromARGB(255, 35, 148, 214).withOpacity(.5),
                          //the more colors here, the more wave will be
                        ],
                        durations: [4000, 5000, 7000],
                        //durations of animations for each colors,
                        // make numbers equal to numbers of colors
                        heightPercentages: [0.01, 0.05, 0.03],
                        //height percentage for each colors.
                        blur: MaskFilter.blur(BlurStyle.solid, 5),
                        //blur intensity for waves
                      ),
                      waveAmplitude: 35.00, //depth of curves
                      waveFrequency: 3, //number of curves in waves
                      //backgroundColor: Colors.white, //background colors
                      size: Size(double.infinity, 150),
                    )),
              ],
            ),
          )),
    );
  }
}

class WaveShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var p = Path();
    p.lineTo(0, 0);
    p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, height);
    p.lineTo(width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
