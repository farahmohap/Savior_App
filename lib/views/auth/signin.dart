import 'package:application/controllers/signin_auth.dart';
import 'package:application/views/auth/signup.dart';
import 'package:application/views/features/dragabble.dart';
import 'package:application/views/widgets/waves.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 

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
                            "Sign In".tr,
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
                                  labelText: 'Email or Phone number'.tr,
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
                                  labelText: 'Password'.tr,
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
                                child: Text("Forget password".tr,
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
                              'Sign In'.tr,
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
                                Get.off(DragHome());
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
                                "Don't have account?".tr,
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
                                    "Sign Up".tr,
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
           Waves()
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
