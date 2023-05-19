import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:application/views/auth/signin.dart';
import 'package:application/views/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 200,
        duration: 2000 ,
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        animationDuration: Duration(seconds: 2),
        splash: Center(
          child: Stack(
            children: [
              Text("SAVIOR",style: TextStyle(color: Color.fromARGB(255, 6, 44, 97),fontWeight: FontWeight.bold,fontFamily:"Macondo",fontSize: 15,letterSpacing: 5),),
              CircleAvatar(
                backgroundImage: AssetImage("images/drowning.jpg"),
                radius: 90,
              ),
             Text("Swim Safe ",style: TextStyle(color: Color.fromARGB(255, 6, 44, 97),fontWeight: FontWeight.bold,fontFamily:"Macondo",fontSize: 15,letterSpacing: 5),),

            ],
          ),
        ),
        nextScreen: SignIn());
  }
}
