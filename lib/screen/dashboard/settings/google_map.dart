import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapController;
  Set<Marker> marker = {};
  LatLng location1 = const LatLng(27.7448979, 85.334329);
  LatLng location2 = const LatLng(27.744950, 85.333071);
  LatLng location3 = const LatLng(27.744947, 85.335461);

  @override
  void initState() {
    marker.add(
      Marker(
        markerId: MarkerId(location1.toString()),
        position: location1,
        infoWindow: const InfoWindow(title: 'FoodMobie', snippet: "FoodMobie"),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    marker.add(
      Marker(
        markerId: MarkerId(location2.toString()),
        position: location2,
        infoWindow: const InfoWindow(title: 'FoodMobie', snippet: "FoodMobie"),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    marker.add(
      Marker(
        markerId: MarkerId(location3.toString()),
        position: location3,
        infoWindow: const InfoWindow(title: 'FoodMobie', snippet: "FoodMobie"),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Map'),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: location1, zoom: 15),
          markers: marker,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
        ));
  }
}
