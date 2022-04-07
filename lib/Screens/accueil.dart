import 'package:abir_sabil/Providers/restaurant.dart';
import 'package:abir_sabil/Screens/profile.dart';
import 'package:abir_sabil/Screens/restaurant_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Providers/DzData.dart';

class accueil extends StatefulWidget {
  const accueil({Key? key}) : super(key: key);

  @override
  State<accueil> createState() => _accueilState();
}

class _accueilState extends State<accueil> {
  final user = FirebaseAuth.instance;
  TextEditingController WilayaTEC = TextEditingController();
  bool _isLoading = false;

  Future<void> getRests() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Restaurants>(context, listen: false).getRestaurants();
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  getWilaya() {
    Provider.of<DataDz>(context, listen: false).getWilaya();
  }

  @override
  void initState() {
    // TODO: implement initState
    getRests();
    super.initState();
    getWilaya();
  }

  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size;
    final rests = Provider.of<Restaurants>(context, listen: false);
    String wilaya = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff582e44),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => profile()));
              },
              icon: Icon(Icons.person)),
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
              onPressed: () async {},
            ),
          ),
        ],
        leading: IconButton(
            icon: const Icon(
              Icons.filter_list_alt,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  // user must tap button!
                  builder: (
                    BuildContext ctx,
                  ) {
                    return AlertDialog(
                        title: Text(
                          'اختر منطقة تواجدك',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: sizee.width * (25 / 540)),
                        ),
                        content: StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: sizee.height * 0.05),
                              width: sizee.width * (210 / 540),
                              height: sizee.height * (65 / 912),
                              child: TypeAheadField(
                                direction: AxisDirection.up,
                                textFieldConfiguration: TextFieldConfiguration(
                                  cursorColor: const Color(0xff582e44),
                                  controller: WilayaTEC,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(
                                      color: const Color(0xff582e44),
                                    ),
                                    hoverColor: Colors.black,
                                    focusColor: const Color(0xff582e44),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xff582e44),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'الولاية',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                ),
                                suggestionsCallback: (pattern) {
                                  if (pattern.isEmpty) {
                                    return [];
                                  }
                                  // The logic to find out which ones should appear
                                  return Provider.of<DataDz>(context,
                                          listen: false)
                                      .wilayaa
                                      .where((suggestion) => suggestion
                                          .toLowerCase()
                                          .contains(pattern.toString()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion.toString()),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  setState(() {
                                    wilaya = suggestion.toString();
                                    WilayaTEC =
                                        TextEditingController(text: wilaya);
                                  });
                                },
                              ),
                            );
                          },
                        ));
                  });
            }),
        title: Center(
            child: Text(
          'عابر سبيل',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: sizee.height * 0.85,
                margin: EdgeInsets.symmetric(
                    horizontal: sizee.width * 0.03,
                    vertical: sizee.height * 0.02),
                child: ListView.builder(
                    itemCount: rests.rests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: sizee.width * 0.8,
                        height: sizee.height * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff582e44).withOpacity(0.05),
                              spreadRadius: 5,
                              blurRadius: 10,

                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: sizee.width * 0.03,
                            vertical: sizee.height * 0.01),
                        padding: EdgeInsets.only(top: sizee.height * 0.015),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffbd7344),
                              radius: sizee.width * (18 / 540),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.arrow_back_ios_outlined),
                                iconSize: sizee.width * (28 / 540),
                                color: Colors.white,
                                onPressed: () async {
                                  rests.restoById(rests.rests[index].id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            restaurant_details(
                                                title: rests.chosenRestaurant!
                                                    .restName!)),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: sizee.height * 0.02,
                                    horizontal: sizee.width * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      rests.rests[index].restName!,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Text(
                                      '${rests.rests[index].city!} ,${rests.rests[index].commune!} ',
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("assets/restaurant.jpg"),
                                    ),
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
                                      const Radius.circular(20),
                                    ),
                                  ),
                                  height: sizee.height * 0.13,
                                  width: sizee.height * 0.13,
                                ),
                                Container(
                                  width: sizee.height * 0.13,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Color(0xffbd7344),
                                      ),
                                      Text('  25  ')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
