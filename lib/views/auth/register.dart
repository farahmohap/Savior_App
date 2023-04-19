import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Form_sign_up.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Container(fdfdfd
        //     coration: BoxDecoration(
        //      color: Colors.lightBlueAccent
        //     ),
        //     child: null
        // ),fgdgfbvbvkgjhjjkjh
        Container(
            //height: 530,
            decoration: const BoxDecoration(
              //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120),bottomRight: Radius.circular(120)),
              image: DecorationImage(
                image: AssetImage("images/bandd.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: null),
        Container(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Form_sign_up(),
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
