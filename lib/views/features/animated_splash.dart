import 'package:application/views/auth/signin.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AnimatedSplash extends StatefulWidget {
  const AnimatedSplash({super.key});

  @override
  State<AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  bool animate = false;
  @override
  void initState() {
    // TODO: implement initState
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          AnimatedPositioned(
              duration: Duration(microseconds: 1500),
              child: CircleAvatar(backgroundImage: AssetImage("images/duck.png")),
              top: animate ? 50 : 10,
              left: animate ? 50: 30),
          Positioned(child: Text("Hii2"), top: 80, left: 30),
          Positioned(child: Text("Hi3"), top: 50, left: 0),
          Positioned(child: Text("Hii4"), top: 100, left: 40),
        ]),
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(microseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(Duration(microseconds: 500));
    Get.to(SignIn());
  }
}
