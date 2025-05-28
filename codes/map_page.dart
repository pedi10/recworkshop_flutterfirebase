import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /*
  This screen displays a Google Map centered on Kuala Lumpur with markers for specific locations.
  It uses the Google Maps Flutter plugin to render the map and display markers.
  The map is initialized with a camera position over Kuala Lumpur, and it includes three markers:
  - KLCC area
  - Mid Valley area
  - Bukit Bintang area
  Each marker has an info window that appears when tapped.
  The map supports various gestures like zooming, rotating, and scrolling.
  The map is styled with rounded corners and padding for better aesthetics.
  */

  // ------- VARIABLES ------- //

  // Google Maps controller
  late GoogleMapController mapController;

  // Initial camera position centered on Kuala Lumpur
  static const CameraPosition _kualaLumpur = CameraPosition(
    target: LatLng(3.139, 101.6869), // KL coordinates
    zoom: 12.0,
  );

  // Set of markers with locations in KL
  final Set<Marker> _markers = {
    // KLCC area with custom red marker
    Marker(
      markerId: const MarkerId('klcc'),
      position: const LatLng(3.1578, 101.7123),
      infoWindow: const InfoWindow(title: 'KLCC Mission'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    // Mid Valley area with custom blue marker
    Marker(
      markerId: const MarkerId('midvalley'),
      position: const LatLng(3.1184, 101.6764),
      infoWindow: const InfoWindow(title: 'Mid Valley Mission'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    // Bukit Bintang area with custom green marker
    Marker(
      markerId: const MarkerId('bukitbintang'),
      position: const LatLng(3.1478, 101.7108),
      infoWindow: const InfoWindow(title: 'Bukit Bintang Mission'),
    ),
  };

  // Called when the map is ready
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // ------- BUILD ------- //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Robot Locations')),
      // Use a Container to add padding and rounded corners around the map
      body: Container(
        margin: const EdgeInsets.all(25.0), // 25px padding around the map
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          color: Theme.of(context).cardColor, // Use card color from theme
        ),
        // ClipRRect to apply rounded corners to the map, because GoogleMap does not support border radius directly
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          // GoogleMap widget with initial camera position and markers
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _kualaLumpur,
            markers: _markers,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            minMaxZoomPreference: const MinMaxZoomPreference(10.0, 20.0),
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
          ),
        ),
      ),
    );
  }
}
