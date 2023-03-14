import 'package:application/views/dragabble.dart';
import 'package:application/views/info.dart';
import 'package:application/views/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/home_page_controllers/getdata.dart';

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
          }
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(Icons.location_on_outlined, color: Colors.white),
          Icon(Icons.device_hub_rounded, color: Colors.white),
          Icon(Icons.emergency, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ]);
  }
}

class Location {
  static getMapp(context) {
   // var myMarker = HashSet<Marker>();
    final Set<Marker> markers = new Set(); //markers for google map
    late GoogleMapController mapController; //controller for Google map

    LatLng showLocation = LatLng(
        GetData.latitiude!.value, GetData.longitude!.value);
    Set<Marker> getmarkers() {
      //markers to place on map
      // setState(() {
      //for (int i = 0; i < GetData.data.length; i++) {
      //avtiveeeeeeeee
      markers.add(Marker(
        //add first marker
        markerId:
            MarkerId(showLocation.toString()), //GetData.data['activedeviceid']
        position: showLocation, //position of marker
        onTap: (() {
          //setState(() {
         Get.to(Info()); //Info(bpm,spo2,showlocation)
                  
          //  });
        }),
        infoWindow: InfoWindow(
            //popup info
            title: '#1K82s', //GetData.data['deviceid']
            snippet: 'Stable',
            onTap: (() {
              // setState(() {
              Get.to(Info());
              // });
            })),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      //}

      return markers;
    }

    return GoogleMap(
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
    );
  }
}
