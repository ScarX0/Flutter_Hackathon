import 'dart:convert';
import 'dart:io';

import 'package:abir_sabil/Providers/auth.dart';
import 'package:abir_sabil/Screens/Map.dart';
import 'package:abir_sabil/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:location/location.dart';
import 'package:provider/provider.dart';
// import 'package:geocoder/geocoder.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  double? lat;
  double? long;

  getAddressFromLatLng(context, double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url =
        '$_host?key=AIzaSyDr4ElWM1yVRYWE6ldvD3mhGokioUb4-SA&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else
        return null;
    } else
      return null;
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

  bool changer = false;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> getInfos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthService>(context, listen: false).getUserInfos();
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WidthSize = MediaQuery.of(context).size.width;
    final HeightSize = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final prov = Provider.of<AuthService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4FBDBA).withOpacity(0.5),
          actions: [
            // Container(
            //   height: WidthSize * 0.12,
            //   width: WidthSize * 0.12,
            //   decoration: BoxDecoration(
            //     color: Color(0xff4FBDBA),
            //     borderRadius: BorderRadius.circular(80.0),
            //   ),
            //   margin: EdgeInsets.only(
            //       top: MediaQuery.of(context).padding.top,
            //       left: WidthSize * 0.01),
            //   child:
            InkWell(
                child:
                    // child: Transform.rotate(
                    //   angle: 180 * math.pi / 180,
                    //   child:
                    Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: WidthSize * (40.0 / 540),
                  ),
                ),
                // ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // showDialog<String>(
                  //   context: context,
                  //   builder: (BuildContext context) => AlertDialog(
                  //     title: const Text('تسجبيل الخروج'),
                  //     content: const Text('متأكد ؟'),
                  //     actions: <Widget>[
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context, 'Cancel'),
                  //         child: const Text(
                  //           'لا',
                  //           style: TextStyle(color: Color(0xff4FBDBA)),
                  //         ),
                  //       ),
                  //       TextButton(
                  //         onPressed: () async {
                  //           // Navigator.pop(ctx);
                  //           await FirebaseAuth.instance.signOut();
                  //         },
                  //         child: const Text(
                  //           'نعم',
                  //           style: TextStyle(color: Color(0xff4FBDBA)),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                }),
            // ),
          ],
          leading: !nu
              ? Container(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : IconButton(
                          icon: Icon(Icons.gps_fixed_outlined),
                          onPressed: () async {
                            await getLoc().then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MapScreen(
                                        latitude: lat!, longitude: long!))));
                          },
                        ),
                )
              : null,
        ),
        backgroundColor: Color(0xff4FBDBA).withOpacity(0.5),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  // height: HeightSize,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: Color(0xff072227),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: HeightSize * 0.32,
                            ),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff4FBDBA)
                                        .withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      //  bottomLeft: Radius.circular(100),
                                    ),
                                  ),
                                  child: Container()),
                            )
                          ],
                        ),
                      ),

                      //////

                      ///////
                      Container(
                        margin: EdgeInsets.only(top: HeightSize * 0.22),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: WidthSize * (80 / 540),
                              ),
                              SizedBox(
                                  child: GestureDetector(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        TextStyle style = TextStyle(
                                          fontSize: WidthSize * 0.03148,
                                          fontFamily: 'Baloo Thambi 2',
                                          color: Colors.white,
                                        );
                                        return AlertDialog(
                                          title: Text(
                                            'اختر صورة',
                                            style: TextStyle(
                                              fontSize: WidthSize * 0.03148,
                                              fontFamily: 'Baloo Thambi 2',
                                              color: Colors.black,
                                            ),
                                          ),
                                          actions: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Color(0xff4FBDBA)),
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  'التقط صورة',
                                                  style: style,
                                                ),
                                                minLeadingWidth: 1.0,
                                                onTap: () async {},
                                              ),
                                            ),
                                            SizedBox(
                                                height: HeightSize * 0.01644),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Color(0xff4FBDBA)),
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons.photo_album_outlined,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  'اختر من معرض الصور',
                                                  style: style,
                                                ),
                                                minLeadingWidth: 1.0,
                                                onTap: () async {},
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: HeightSize * 0.01),
                                  child: Text(
                                    "تغيير الصورة الشخصية",
                                    style: TextStyle(
                                      fontSize: WidthSize * 0.032,
                                      color: Colors.white,
                                      fontFamily: 'Gothic',
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              )),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: HeightSize * 0.05),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "الاسم  ",
                                          style: TextStyle(
                                              fontSize: WidthSize * (30 / 540),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'Gothic'),
                                        ),
                                        Text(
                                          "البريد الالكتروني",
                                          style: TextStyle(
                                              fontSize: WidthSize * (30 / 540),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'Gothic'),
                                        ),
                                        Text(
                                          "رقم الهاتف",
                                          style: TextStyle(
                                              fontSize: WidthSize * (30 / 540),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'Gothic'),
                                        ),
                                        !changer
                                            ? SizedBox(
                                                height: HeightSize * 0.22,
                                              )
                                            : SizedBox(
                                                height: HeightSize * 0.08,
                                              ),
                                      ],
                                    ),
                                    changer
                                        ? Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    WidthSize *
                                                                        0.05),
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Color(
                                                                        0xff072227)),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                                side:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons.clear,
                                                            color: Colors.white,
                                                            size: 32.0,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              changer = false;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: WidthSize *
                                                                0.07),
                                                        width: WidthSize * 0.65,
                                                        child: Form(
                                                          key: _formKey,
                                                          child: TextFormField(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            textAlign:
                                                                TextAlign.right,
                                                            controller:
                                                                _nameController,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value.length <
                                                                      2) {
                                                                return 'Invalid name';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (value) {},
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            cursorColor: Color(
                                                                0xff4FBDBA),
                                                            decoration:
                                                                InputDecoration(
                                                              errorStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Gothic',
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0)),

                                                              hoverColor:
                                                                  Colors.black,
                                                              focusColor: Color(
                                                                  0xff4FBDBA),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: Color(
                                                                            0xff4FBDBA),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0)),
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                                              hintText:
                                                                  'الاسم الجديد',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              suffixIcon:
                                                                  const Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: HeightSize * 0.03,
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),

                                    RaisedButton(
                                      onPressed: () async {
                                        if (changer) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              changer = false;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            changer = true;
                                          });
                                        }
                                      },
                                      padding: const EdgeInsets.all(0.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Container(
                                        width: WidthSize * 0.9,
                                        height: HeightSize * 0.09,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff072227),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: Center(
                                          child: Text(
                                            !changer ? "تغيير الاسم" : "تحديث",
                                            style: TextStyle(
                                              fontFamily: "Gothic",
                                              fontSize: WidthSize * (25 / 540),
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Text(snapshot
                                    //     .data!
                                    //     .docs[snapshot.data!.docs.indexWhere((element) =>
                                    // element['id'] ==
                                    //     Provider.of<AuthService>(context, listen: false).ID)]
                                    //     .id),
                                    // RaisedButton(
                                    //   onPressed: () async {
                                    //     await FirebaseFirestore.instance
                                    //         .collection('users')
                                    //         .doc(snapshot
                                    //         .data!
                                    //         .docs[snapshot.data!.docs.indexWhere((element) =>
                                    //     element['id'] ==
                                    //         Provider.of<AuthService>(context, listen: false)
                                    //             .ID)]
                                    //         .id)
                                    //         .update({"name": "hello"});
                                    //   },
                                    //   textColor: Color(0xffE50914),
                                    //   padding: const EdgeInsets.all(0.0),
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(20.0)),
                                    //   child: Container(
                                    //     width: 90,
                                    //     height: 40,
                                    //     decoration: const BoxDecoration(
                                    //         color: Colors.blue,
                                    //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    //     child: Center(
                                    //       child: Text(
                                    //         "modify",
                                    //         style: TextStyle(
                                    //           fontFamily: "Gothic",
                                    //           fontSize: 18,
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //         textAlign: TextAlign.center,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Container(
                                    //   color: Colors.yellow,
                                    //   height: 250,
                                    //   child: ListView.builder(
                                    //       itemCount: snapshot.data!.docs.length,
                                    //       itemBuilder: (BuildContext context, int index) {
                                    //         return ListTile(
                                    //             trailing: Text(
                                    //               snapshot.data!.docs[index]['isBoutique']
                                    //                   ? "BT"
                                    //                   : "/",
                                    //               style:
                                    //               TextStyle(color: Colors.green, fontSize: 15),
                                    //             ),
                                    //             title:
                                    //             Text("${snapshot.data!.docs[index]['name']}"));
                                    //       }),
                                    // ),
                                    // RaisedButton(
                                    //   onPressed: () async {
                                    //     await authService.signOut();
                                    //   },
                                    //   textColor: Color(0xffE50914),
                                    //   padding: const EdgeInsets.all(0.0),
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(20.0)),
                                    //   child: Container(
                                    //     width: 90,
                                    //     height: 40,
                                    //     decoration: const BoxDecoration(
                                    //         color: Colors.white,
                                    //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    //     child: Center(
                                    //       child: Text(
                                    //         "logout",
                                    //         style: TextStyle(
                                    //           fontFamily: "Gothic",
                                    //           fontSize: 18,
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //         textAlign: TextAlign.center,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
