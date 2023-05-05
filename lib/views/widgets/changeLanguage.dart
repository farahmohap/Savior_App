import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rolling_switch/rolling_switch.dart';

import '../../controllers/locale/locale_controller.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    MyLocaleController langcontroller = Get.find();

    return RollingSwitch.icon(
     
        width: 100,
        onChanged: (bool state) {
          if (state == true) {
            setState(() {
              langcontroller.changeLanguage("en");
            });
          }else {
            setState(() {
              langcontroller.changeLanguage("ar");
            });
          }
        },
        rollingInfoRight: const RollingIconInfo(
          text: Text('Ar'),
        ),
        rollingInfoLeft: const RollingIconInfo(
          backgroundColor: Color.fromARGB(255, 123, 121, 121),
          text: Text('En'),
        ));
  }
}
