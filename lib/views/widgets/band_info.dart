import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BandInfo extends StatelessWidget {
  var user;
  var age;
  var phone;
  BandInfo({required user, required age, required phone}) {
    this.user = user;
    this.age = age;
    this.phone = phone;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bandInfoItem(
          Color.fromARGB(255, 205, 211, 222),
          "images/headband.png",
          "ID".tr,
          "11F455d",
        ),
        bandInfoItem(Color.fromARGB(255, 181, 199, 235),
            "images/headbandUser.png", "Username".tr, this.user),
        bandInfoItem(
          Color.fromARGB(255, 142, 176, 243),
          "images/agerange.png",
          "Age".tr,
          this.age,
        ),
        bandInfoItem(
          Color.fromARGB(255, 79, 118, 189),
          "images/phone.png",
          "Phone".tr,
          this.phone,
        ),
      ],
    );
  }

  Card bandInfoItem(Color color, String imgPath, String title, data) {
    return Card(
      color: color,
      child: ListTile(
        leading: Image.asset(
          imgPath,
          width: 35,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          data,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
