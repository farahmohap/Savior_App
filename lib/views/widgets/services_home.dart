import 'package:application/views/features/data_history.dart';
import 'package:flutter/material.dart';
import 'package:application/views/features/devices.dart';
import 'package:application/views/features/mapp.dart';
import 'package:application/views/settings/settings.dart';
import 'package:get/get.dart';
import '../features/dragabble.dart';

class ServicesHome extends StatefulWidget {
  ServicesHome({super.key});

  @override
  State<ServicesHome> createState() => _ServicesHomeState();
}

class _ServicesHomeState extends State<ServicesHome>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(7),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              service('Map', Mapp(), 'images/map.png'),
              service('Devices', Devices(), 'images/connection.png')
            ]),
            SizedBox(
              height: size.height * .02,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              service('History', DataHistory(), 'images/history.png'),
              service('Settings', Settingss(), 'images/settings.png'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget service(String title, route, String imgPath) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(.5),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Column(
        children: [
          IconButton(
            tooltip: title.tr,
            splashRadius: 50,
            iconSize: 130,
            onPressed: () {
              Get.to(route);
            },
            icon: Image.asset(
              imgPath,
            ),
          ),
          Text(
            title.tr,
            style: TextStyle(
              color: Color.fromARGB(255, 6, 44, 97),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
