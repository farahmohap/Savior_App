import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';



class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final DatabaseReference _locationReference = FirebaseDatabase.instance.ref().child('ESP32-v1');
  final StreamController<LatLng> _locationStreamController = StreamController<LatLng>();

  @override
  void initState() {
    super.initState();
    _locationReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<String, dynamic>;
      final location = data['lat'] != null && data['lon'] != null
          ? LatLng(data['lat'], data['lon'])
          : null;
      _locationStreamController.add(location!);
    });
  }

  @override
  void dispose() {
    _locationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps Demo'),
      ),
      body: StreamBuilder<LatLng>(
        stream: _locationStreamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final location = snapshot.data!;
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: location,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: MarkerId('current_location'),
                position: location,
              ),
            },
          );
        },
      ),
    );
  }
}
