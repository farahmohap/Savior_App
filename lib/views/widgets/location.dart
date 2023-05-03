import 'package:application/models/getdata.dart';
import 'package:application/views/features/info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  DatabaseReference infoRef = FirebaseDatabase.instance.ref('ESP32-v1');

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DatabaseEvent>(
        stream: infoRef.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = Map<String, dynamic>.from(snapshot.data.snapshot.value);
          double lat = data['latitude'];
          double long = data['longitude'];

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

            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
                markers.add(Marker(
                    markerId: MarkerId(LatLng(lat, long).toString()),
                    position: LatLng(lat, long),
                    infoWindow: InfoWindow(
                        //popup info
                        title: 'Stable', //GetData.data['deviceid']
                        // snippet: 'Stable',
                        onTap: (() {
                          Get.to(Info(
                            bpm: data['heartrate'],
                            spo2: GetData.spo2,
                            user: GetData.name,
                            age: GetData.age,
                            phone: GetData.phone,
                          ));
                        })),
                    icon: BitmapDescriptor.defaultMarker));
              });

              // _getPolyline();
            },
            markers: markers,
          );
        },
      ),
    );
  }
}
