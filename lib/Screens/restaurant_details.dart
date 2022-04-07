import 'package:abir_sabil/Providers/restaurant.dart';
import 'package:abir_sabil/Screens/Map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class restaurant_details extends StatefulWidget {
  final String title;
  const restaurant_details({Key? key, required this.title}) : super(key: key);

  @override
  State<restaurant_details> createState() => _restaurant_detailsState();
}

class _restaurant_detailsState extends State<restaurant_details> {
  bool _isLoading = false;
  double? lat;
  double? long;
  Map<String, dynamic>? menu = {};
  Future<void> reserve() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final rest =
          Provider.of<Restaurants>(context, listen: false).chosenRestaurant;
      final data = await FirebaseFirestore.instance
          .collection('menus')
          .doc(rest!.id)
          .get();
      final prevValue = data.data();
      await FirebaseFirestore.instance
          .collection('menus')
          .doc(rest.id)
          .update({'repas_dispo': prevValue!['repas_dispo'] - 1});
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getLoc() async {
    setState(() {
      _isLoading = true;
    });
    var location = Location();

    var locationEnabled = await location.serviceEnabled();

    if (!locationEnabled) {
      locationEnabled = await location.requestService();
      if (!locationEnabled) {
        return;
      }
    }

    var _permission = await location.hasPermission();
    if (_permission == PermissionStatus.denied) {
      _permission = await location.requestPermission();
      if (_permission != PermissionStatus.granted) {
        return;
      }
    }

    var currentLocation = await location.getLocation();

    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    // getAddressFromLatLng(context, lat!, long!);

    // final coordinates = Coordinates(lat, long);
    // var addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);

    // print(addresses);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getMenu() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final rest =
          Provider.of<Restaurants>(context, listen: false).chosenRestaurant;

      final data = await FirebaseFirestore.instance
          .collection('menus')
          .doc(rest!.id)
          .get();
      menu = data.data();
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getMenu();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size;
    final rest = Provider.of<Restaurants>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff582e44),
        title: Center(child: Text('مطعم الرحمة')),
        actions: [
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Container(
        height: sizee.height,
        width: sizee.width,
        margin: EdgeInsets.only(
            top: sizee.height * 0.04, bottom: sizee.height * 0.05),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: sizee.height * 0.02),
                      height: sizee.height * 0.3,
                      width: sizee.width * 0.35,
                      child: Column(
                        children: [
                          Container(
                              width: sizee.width * 0.35,
                              decoration: BoxDecoration(
                                color: Color(0xffbd7344),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.05),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: Center(
                                  child: Text(
                                '${rest.chosenRestaurant!.city}, ${rest.chosenRestaurant!.commune}',
                                style: TextStyle(color: Colors.white),
                              ))),
                          Container(
                              width: sizee.width * 0.35,
                              margin: EdgeInsets.symmetric(
                                  vertical: sizee.height * 0.012),
                              decoration: BoxDecoration(
                                color: Color(0xffbd7344),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.05),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: Center(
                                  child: Text(
                                'متوفر ${menu!['repas_dispo']} مقعد ',
                                style: TextStyle(color: Colors.white),
                              ))),
                          _isLoading
                              ? CircularProgressIndicator()
                              : Container(
                                  child: InkWell(
                                  onTap: () async {
                                    await reserve();
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'احجز مقعد',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    width: sizee.width * 0.24,
                                    height: sizee.height * 0.05,
                                    margin: EdgeInsets.only(
                                        top: sizee.height * 0.01),
                                    decoration: BoxDecoration(
                                      color: Color(0xff582e44),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.05),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                )),
                          Container(
                            width: sizee.width * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: sizee.width * 0.1,
                                    margin: EdgeInsets.symmetric(
                                        vertical: sizee.height * 0.02),
                                    decoration: BoxDecoration(
                                      color: Color(0xff582e44),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.05),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          launch(rest.chosenRestaurant!.phone!);
                                        },
                                      ),
                                    )),
                                Container(
                                    width: sizee.width * 0.1,
                                    margin: EdgeInsets.symmetric(
                                        vertical: sizee.height * 0.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xff582e44),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.05),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.place,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'هل تسمح للتطبيق بتحديد مكانك من أجل إرشادك الى المطعم ؟'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(ctx);
                                                          await getLoc().then((value) =>
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (_) =>
                                                                          MapScreen(
                                                                            latitude:
                                                                                lat!,
                                                                            longitude:
                                                                                long!,
                                                                            user:
                                                                                true,
                                                                          ))));
                                                          Navigator.pop(ctx);
                                                        },
                                                        child: Text('تأكيد')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(ctx);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      MapScreen(
                                                                        latitude: rest
                                                                            .chosenRestaurant!
                                                                            .latitude!,
                                                                        longitude: rest
                                                                            .chosenRestaurant!
                                                                            .longitude!,
                                                                        user:
                                                                            false,
                                                                      )));
                                                        },
                                                        child: Text('رفض')),
                                                  ],
                                                );
                                              });

                                          // launchMap();
                                        },
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    height: sizee.height * 0.3,
                    width: sizee.width * 0.6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/restaurant.jpg"),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: sizee.height * 0.03,
                  horizontal: sizee.width * 0.03),
              margin: EdgeInsets.symmetric(
                  vertical: sizee.height * 0.05,
                  horizontal: sizee.width * 0.05),
              decoration: BoxDecoration(
                color: Color(0xffbd7344).withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: sizee.height * 0.3,
              child: Column(
                children: [
                  Center(
                      child: Text(
                    'قائمة اليوم',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Container(
                    width: sizee.width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${menu!['soupe']}'),
                        Text('${menu!['plat_principal']}'),
                        Text('${menu!['plat_sec']}'),
                        Text('${menu!['entree']}'),
                        Text('${menu!['dessert']}'),
                        Text('${menu!['autre']}'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: sizee.height * 0.00,
                  horizontal: sizee.width * 0.05),
              decoration: BoxDecoration(
                color: Color(0xffa8293c).withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: sizee.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Center(
                        child: Text(
                          'تطوع',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: sizee.width * 0.2,
                      height: sizee.height * 0.05,
                      margin: EdgeInsets.only(top: sizee.height * 0.01),
                      decoration: BoxDecoration(
                        color: Color(0xffa8293c),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  )),
                  Text(
                    'متطوع ${rest.chosenRestaurant!.needNumberVols} نحتاج',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  launchMap({String lat = "47.6", String long = "-122.3"}) async {
    var mapSchema = 'geo:$lat,$long';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }
}
