import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(-9.9494749, -62.9652482);

  final List<Marker> _markers = [
    Marker(
      markerId: const MarkerId('marker1'),
      position: LatLng(-9.923573802041773, -63.033260991582225),
      infoWindow: const InfoWindow(title: 'Localização 1'),
    ),
    Marker(
      markerId: const MarkerId('marker2'),
      position: LatLng(-9.916634656463286, -63.04989536274654),
      infoWindow: const InfoWindow(title: 'Localização 2'),
    ),
    // Adicione mais marcadores conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Endereço',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: Set<Marker>.from(_markers),
      ),
    );
  }
}
