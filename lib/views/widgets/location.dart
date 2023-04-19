import 'package:application/models/getdata.dart';
import 'package:application/views/features/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _LocationState();
}

class _LocationState extends State<GetLocation> {
  final Set<Marker> markers = new Set(); //markers for google map
  late GoogleMapController mapController; //controller for Google map
  LatLng showLocation = LatLng(
      double.parse(GetData.latitiude!), double.parse(GetData.longitude!));
  Set<Marker> getmarkers() {
    //markers to place on map
    // setState(() {
    //for (int i = 0; i < GetData.data.length; i++) {
    //avtiveeeeeeeee
    markers.add(Marker(
      //add first marker
      markerId:MarkerId(showLocation.toString()), //GetData.data['activedeviceid']
      position: showLocation, //position of marker
      onTap: (() {
        //setState(() {
        Get.to(Info(
          bpm: GetData.bpm,
          spo2: GetData.spo2,
          user: GetData.name,
          age: GetData.age,
          phone: GetData.phone,
        )); //Info(bpm,spo2,showlocation)

        //  });
      }),
      infoWindow: InfoWindow(
          //popup info
          title: '#1K82s', //GetData.data['deviceid']
          snippet: 'Stable',
          onTap: (() {
            // setState(() {
            Get.to(Info(
              bpm: GetData.bpm,
              spo2: GetData.spo2,
              user: GetData.name,
              age: GetData.age,
              phone: GetData.phone,
            ));
            // });
          })),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    //}

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      //polylines: Set<Polyline>.of(polylines.values),
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      compassEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: true,
      cameraTargetBounds: CameraTargetBounds.unbounded,
      initialCameraPosition: CameraPosition(
        target: showLocation,
        zoom: 45,
      ),
      onMapCreated: (controller) {
        //method called when map is created
        //setState(() {
        mapController = controller;
        // _getPolyline();
        // });
      },
      markers: getmarkers(),
    ));
  }
}
