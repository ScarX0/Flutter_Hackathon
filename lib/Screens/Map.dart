import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapScreen({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? _origin;
  Marker? _destination;
  GoogleMapController? _googleMapController;
  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraPosition = CameraPosition(
        target: LatLng(widget.latitude, widget.longitude), zoom: 12);

    return Scaffold(
      appBar: AppBar(
          title: TextButton(
        child: Text('حفظ مكاني'),
        onPressed: () {},
      )),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: cameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {
          if (_origin != null) _origin!,
          if (_destination != null) _destination!
        },
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _googleMapController!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) {
    if ((_origin == null) || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
            markerId: MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'current position'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: pos);
      });
      _destination = null;
    } else {
      setState(() {
        _destination = Marker(
            markerId: MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet),
            position: pos);
        print(_destination!.position.latitude);
        print(_destination!.position.longitude);
      });
      // _destination = null;

    }
  }
}
