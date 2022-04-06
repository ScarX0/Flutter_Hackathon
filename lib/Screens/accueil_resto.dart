import 'package:abir_sabil/Screens/menu.dart';
import 'package:abir_sabil/Screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:numberpicker/numberpicker.dart';

class accueil_resto extends StatefulWidget {
  const accueil_resto({Key? key}) : super(key: key);

  @override
  State<accueil_resto> createState() => _accueil_restoState();
}

class _accueil_restoState extends State<accueil_resto> {
  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size;
    final WidthSize = MediaQuery.of(context).size.width;

    String locale = 'ar';
    int persons = 1;
    //Suppose current gregorian data/time is: Mon May 29 00:27:33  2018
    HijriCalendar _today = HijriCalendar.now();
    HijriCalendar.setLocal(locale);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => profile()));
          },
        ),
        actions: [
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
              })
        ],
        backgroundColor: Color(0xff582e44),
        title: Center(child: Text("مطعم الرحمة")),
      ),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
            ),
            elevation: 30,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/ramadhan.png"),
                ),
              ),
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(300),
                    ),
                  ),
                  elevation: 30,
                  child: Container(
                    child: Center(
                        child: Text(
                      _today.toFormat("dd MMMM yyyy"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizee.width * 0.07),
                    )),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(300),
                      ),
                    ),
                    height: sizee.height * 0.28,
                    width: sizee.height * 0.28,
                  ),
                ),
              ),
              height: sizee.height * 0.6,
            ),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      // user must tap button!
                      builder: (
                        BuildContext ctx,
                      ) {
                        return AlertDialog(
                          title: Text(
                            'عدد الأشخاص المطلوبين للتطوع',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: sizee.width * (25 / 540)),
                          ),
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            return NumberPicker(
                              textStyle: TextStyle(
                                color: Colors.black,
                              ),
                              selectedTextStyle: TextStyle(
                                color: Color(0xffbd7344),
                              ),
                              value: persons,
                              minValue: 1,
                              maxValue: 90,
                              step: 1,
                              itemHeight: sizee.height * (100 / 912),
                              itemWidth: sizee.width * 0.2,
                              axis: Axis.horizontal,
                              onChanged: (value) =>
                                  setState(() => persons = value),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black26),
                              ),
                            );
                          }),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'تأكيد',
                                style: TextStyle(
                                  color: Color(0xffbd7344),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(300),
                      ),
                    ),
                    elevation: 30,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person_search_outlined,
                            color: Color(0xffbd7344),
                          ),
                          // icon
                          Text(
                            "متطوعين",
                            style: TextStyle(color: Color(0xffbd7344)),
                          ),
                          // text
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(300),
                        ),
                      ),
                      height: sizee.height * 0.1,
                      width: sizee.height * 0.1,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => menu()),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(300),
                      ),
                    ),
                    elevation: 30,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.flatware_outlined,
                            color: Colors.white,
                          ),
                          // icon
                          Text(
                            "وجبة اليوم",
                            style: TextStyle(color: Colors.white),
                          ),
                          // text
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffbd7344),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(300),
                        ),
                      ),
                      height: sizee.height * 0.15,
                      width: sizee.height * 0.15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(300),
                      ),
                    ),
                    elevation: 30,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.assessment_outlined,
                            color: Color(0xffbd7344),
                          ),
                          // icon
                          Text(
                            "الاحصائيات",
                            style: TextStyle(color: Color(0xffbd7344)),
                          ),
                          // text
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(300),
                        ),
                      ),
                      height: sizee.height * 0.1,
                      width: sizee.height * 0.1,
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
