import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng source = LatLng(37.33500926, -122.03272188);
  static const LatLng dest = LatLng(37.33429383, -122.06600055);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }
double calculateDistance(lat1,long1,lat2,long2)
{
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((long2 - long1) * p))/2;
    return 12742 * asin(sqrt(a));
}
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBqn6p_CblyGJovGgUBq18HDmGbaUOIwEY",
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(dest.latitude, dest.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Google Maps Demo'),
        ),
        body: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
              children:[
               
                 GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation!.latitude!, currentLocation!.longitude!),
                    zoom: 8,
                  ),
                  polylines: {
                      Polyline(
                          polylineId: PolylineId("Route"),
                          points: polylineCoordinates,
                          color: Colors.black,
                          width: 6)
                    },
                  // onMapCreated: (GoogleMapController controller) {
                  //   _controller.complete(controller);
                  // },
                  markers: {
                      const Marker(
                        markerId: MarkerId('ss'),
                        position: source,
                      ),
                      const Marker(
                        markerId: MarkerId('desttss'),
                        position: dest,
                      ),
                      Marker(
                        markerId: MarkerId('current_location'),
                        position: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                      ),
                    }),
           ] ));
  }
}
