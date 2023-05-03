
import 'package:application/views/reusable.dart';
import 'package:flutter/material.dart';
import 'package:application/models/getdata.dart';
import '../widgets/location.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/test.dart';


class Mapp extends StatefulWidget {
  var bpm;
  var spo2;
  Mapp() {
    bpm = GetData.bpm;
    spo2 = GetData.spo2;
  }

  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {
  // late BitmapDescriptor customMarker; //attribute
  // getcustomMarker() async {
  //   customMarker = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration.empty, "images/man",
  //       mipmaps: false);
  // }

  @override
  void initState() {
    super.initState();
    GetData.getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Nav.getNav(context, 1),
      body:
        const SafeArea(     
          bottom: false,
           child: GetLocation()
        ),
      
    );
  }
}
