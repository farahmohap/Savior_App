import 'package:application/views/auth/signup.dart';
import 'package:application/views/features/dragabble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:flutter/widgets.dart';
import 'package:proste_bezier_curve/utils/type/index.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var email = TextEditingController();
  var password = TextEditingController();
  var data_email;
  var data_password;
  ////////////////////////////////////////////////
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        child: Stack(
          children: [
            /* Container(
                //  height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/backsign.jpg'),
                      fit: BoxFit.cover),
                ),
              ),*/
            Container(
              // color: Color.fromARGB(255, 176, 212, 228).withOpacity(.5),
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
                            "Sign In",
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
                                controller: email,

                                //maxLength: 70,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email Or Phone Number',
                                  // hintText: 'Email Or Phone Number',
                                )),
                          ),
                          SizedBox(
                            height: 20,
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
                                  //hintText: 'Password',
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),
                                child: Text("Forget Password",
                                    //textDirection: TextDirection.ltr,
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline)),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          MaterialButton(
                            minWidth: 170,
                            textColor: Colors.black,
                            color: Color.fromARGB(255, 247, 208, 67),
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              data_email = email.text;
                              data_password = password.text;
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: data_email,
                                            password: data_password);
                                print(userCredential);
                                Get.to(DragHome());
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email');
                                } else if (e.code == 'wrong-password') {
                                  print('wrong password');
                                }
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't Have Account?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                                //  textAlign: TextAlign.right,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(SignUp());
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    // textAlign: TextAlign.left,
                                  ))
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
