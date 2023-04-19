import 'package:application/views/features/devices.dart';
import 'package:application/views/features/dragabble.dart';
import 'package:application/views/features/mapp.dart';
import 'package:application/views/settings/settings.dart';
import 'package:application/views/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Nav {
  static getNav(context, int index) {
    return CurvedNavigationBar(
        height: 60,
        index: index,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Style.darkblue,
        color: Style.darkblue,
        animationDuration: const Duration(microseconds: 10),
        animationCurve: Curves.easeInOutCubic,
        onTap: (index) {
          print(index);
          if (index == 0) {
            Get.off(DragHome());
          } else if (index == 1) {
            Get.off(Mapp());
          } else if (index == 2) {
            Get.off(Devices());
          } else if (index == 3) {
            Get.off(Settingss());
          }
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(Icons.location_on_outlined, color: Colors.white),
          Icon(Icons.device_hub_rounded, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ]);
  }
}
