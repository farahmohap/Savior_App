import 'package:application/models/getdata.dart';
import 'package:application/views/features/info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/emergencyCondition.dart';
import '../../controllers/notifications_services.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});
  @override
  State<GetLocation> createState() => _LocationState();
}

class _LocationState extends State<GetLocation> {
  final Set<Marker> markers = {}; //markers for google map
  late GoogleMapController mapController; //controller for Google map
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  void changeMarkerIcon(imgpath) async {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), imgpath)
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  @override
  void initState() {
    changeMarkerIcon("images/ss.png");
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DatabaseEvent>(
          stream: EmergencyCondition.infoRef.onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final data =
                  Map<String, dynamic>.from(snapshot.data.snapshot.value);
              double lat = data['lat'];
              double long = data['lon'];
              var bpm = data['heartrate'];
              var spo2 = data["spo2"];
              var time = data["time"];
              // EmergencyCondition.EmergencyNotification(bpm, spo2);
              // EmergencyCondition.ConstatntTimeNotification(time);
              // EmergencyCondition.DistanceNotification(lat, long);
              // EmergencyCondition.NoResponseData(bpm, spo2);

              // if (bpm > 90) {
              //   changeMarkerIcon("images/no.png");
              //  // EmergencyCondition.StopNotification();
              // }
              // else
              // {changeMarkerIcon("images/ss.png");}
              return Stack(children: [
                GoogleMap(
                    //polylines: Set<Polyline>.of(polylines.values),
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    compassEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: true,
                    cameraTargetBounds: CameraTargetBounds.unbounded,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, long),
                      zoom: 25,
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
                              title: 'Info', //GetData.data['deviceid']
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
                          icon: markerIcon),
                    }),

                // AlertDialog(
                //   title: Text("Emergency Case"),
                //   actions: [
                //     MaterialButton(
                //       onPressed: () {
                //         EmergencyCondition.StopNotification();
                //         Get.to(Info());
                //       },
                //       child: Text("Show"),
                //     ),
                //   ],

                // )
              ]);
            }
          }),
    );
  }
}
