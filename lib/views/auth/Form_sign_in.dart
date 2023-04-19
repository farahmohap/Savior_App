import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Form_sign_in extends StatefulWidget {
  const Form_sign_in({Key? key}) : super(key: key);

  @override
  State<Form_sign_in> createState() => _Form_sign_inState();
}

class _Form_sign_inState extends State<Form_sign_in> {
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

////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return   Center(
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        icon: new Image.asset(
                          "images/bandd.jpg",
                          width: 30,
                          height: 40,
                        ),
                        hintText: " Your Email ",
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 7, 7, 7), width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 12, 12, 12),
                                width: 3)),
                      ),
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 40),
                  TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        icon: new Image.asset(
                          "images/bandd.jpg",
                          width: 30,
                          height: 40,
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 14, 13, 13),
                                width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 14, 13, 13),
                                width: 3)),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () async {
                      data_email = email.text;
                      data_password = password.text;
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: data_email, password: data_password);
                        print(userCredential);
                        Navigator.of(context).pushReplacementNamed("Home");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email');
                        } else if (e.code == 'wrong-password') {
                          print('wrong password');
                        }
                      }
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    minWidth: 400,
                    color: Color.fromARGB(255, 94, 142, 181),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("Register");
                    },
                    child: Text(
                      'Dont have account ?, Sign up Now !',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Or Sign in with Google !',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      UserCredential credential = await signInWithGoogle();
                      Navigator.of(context).pushReplacementNamed('Home');
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bandd.jpg'),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle),
                        child: null),
                  )
                ],
              )),
            ),
        
        
      ),
    );
  }
}
