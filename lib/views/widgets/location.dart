import 'package:application/models/getdata.dart';
import 'package:application/views/features/info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/emergencyCondition.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _LocationState();
}

class _LocationState extends State<GetLocation> {
  final Set<Marker> markers = {}; //markers for google map
  late GoogleMapController mapController; //controller for Google map
  // LatLng showLocation = LatLng(
  //     double.parse(GetData.latitiude!), double.parse(GetData.longitude!));
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }

  double calculateDistance(lat2, long2) {
    var lat1 = currentLocation!.latitude!;
    var long1 = currentLocation!.longitude!;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((long2 - long1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
  // Set<Marker> getmarkers() {
  //   //markers to place on map
  //   // setState(() {
  //   //for (int i = 0; i < GetData.data.length; i++) {
  //   //avtiveeeeeeeee
  //   markers.add(
  //     Marker(
  //     //add first marker
  //     markerId:MarkerId(showLocation.toString()), //GetData.data['activedeviceid']
  //     position: showLocation, //position of marker
  //     onTap: (() {
  //     //  setState(() {
  //       Get.to(Info(
  //         bpm: InfoController.getData().value,
  //         spo2: GetData.spo2,
  //         user: GetData.name,
  //         age: GetData.age,
  //         phone: GetData.phone,
  //       )); //Info(bpm,spo2,showlocation)
  //        // });
  //     }),
  //     infoWindow: InfoWindow(
  //         //popup info
  //         title: '${InfoController.getData().value}', //GetData.data['deviceid']
  //         snippet: 'Stable',
  //         onTap: (() {
  //           // setState(() {
  //           Get.to(Info(
  //         bpm: InfoController.getData().value,
  //         spo2: GetData.spo2,
  //         user: GetData.name,
  //         age: GetData.age,
  //         phone: GetData.phone,
  //           ));
  //           // });
  //         })),
  //     icon: BitmapDescriptor.defaultMarker, //Icon for Marker
  //   )
  //   );
  //   //}
  //   return markers;
  // }

  @override
  void initState() {
    // TODO: implement initState
    //infoRef.onValue.listen((event) {});
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DatabaseEvent>(
        stream: EmergencyCondition.infoRef.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = Map<String, dynamic>.from(snapshot.data.snapshot.value);
          double lat = data['latitude'];
          double long = data['longitude'];
          var bpm = data['heartrate'];
          var spo2 = data["spo2"];
          EmergencyCondition.EmergencyNotification(bpm, spo2);
          return GoogleMap(
              //polylines: Set<Polyline>.of(polylines.values),
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              compassEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: true,
              cameraTargetBounds: CameraTargetBounds.unbounded,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, long),
                zoom: 45,
              ),
              // onMapCreated: (controller) {
              //   mapController = controller;
              //   setState(() {});

              //   // _getPolyline();
              // },
              markers: {
                Marker(
                    markerId: MarkerId(LatLng(lat, long).toString()),
                    position: LatLng(lat, long),
                    //draggable: true,
                    infoWindow: InfoWindow(
                        //popup info
                        title: 'Stable', //GetData.data['deviceid']
                        // snippet: 'Stable',
                        onTap: (() {
                          Get.to(Info(
                            bpm: bpm,
                            spo2: spo2,
                            lat: lat,
                            long: long,
                            user: GetData.name,
                            age: GetData.age,
                            phone: GetData.phone,
                          ));
                        })),
                    icon: BitmapDescriptor.defaultMarker)
              });
        },
      ),
    );
  }
}
