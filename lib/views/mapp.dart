import 'dart:collection';
import 'package:application/views/info.dart';
import 'package:application/views/reusable.dart';
import 'package:application/views/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:floating_overlay/floating_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:application/controllers/home_page_controllers/getdata.dart';
import 'package:application/views/dragabble.dart';
import 'package:application/views/mapp.dart';

int? navIndex;

class Mapp extends StatefulWidget {
  // int? id;
  // Mapp(this.id) {
  //   navIndex = id;
  // }
  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {
  //final Set<Marker> myMarker = new Set();
  // late BitmapDescriptor customMarker; //attribute
  // late GoogleMapController mapController; //controller for Google map
  // final Set<Marker> markers = new Set(); //markers for google map
  // static LatLng showLocation = LatLng(
  //     double.parse(GetData.latitiude!), double.parse(GetData.longitude!));

  // getcustomMarker() async {
  //   customMarker = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration.empty, "images/man",
  //       mipmaps: false);
  // }

  @override
  void initState() {
    super.initState();
    //getcustomMarker();
    //GetData.getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Nav.getNav(context, 1),
      body: Container(
        height: double.infinity,
        child: SafeArea(bottom: false, child: Location.getMapp(context)),
      ),
    );
  }
}
