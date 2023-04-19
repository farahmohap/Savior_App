import 'package:flutter/material.dart';
import 'Form_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
         SafeArea(
           child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Form_sign_in(),
                ],
              ),
         ),
          
      
      
    );
  }
}
