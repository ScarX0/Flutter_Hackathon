import 'package:abir_sabil/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool _isLoading = false;
  Future<void> sendCoordinates() async {
    final auth = FirebaseAuth.instance.currentUser;
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(auth!.uid)
          .update({
        'location': [_origin!.position.latitude, _origin!.position.longitude]
      });
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

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
          backgroundColor: Color(0xff582e44),
          title: !nu
              ? _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : TextButton(
                      child: const Text(
                        'حفظ مكاني',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        Fluttertoast.showToast(msg: 'جاري حفظ المكان');
                        await sendCoordinates()
                            .then((value) => Navigator.pop(context));
                      },
                    )
              : null),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: cameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {
          if (_origin != null) _origin!,
          if (_destination != null) _destination!
        },
        onLongPress: !nu ? _addMarkerForResto : _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _googleMapController!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarkerForResto(LatLng pos) {
    setState(() {
      _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'current position'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos);
    });
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
