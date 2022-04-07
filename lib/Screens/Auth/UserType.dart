import 'package:abir_sabil/Screens/Auth/Signin.dart';
import 'package:abir_sabil/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/auth.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    final authServicer = Provider.of<AuthService>(context);
    final WidthSize = MediaQuery.of(context).size.width;
    final HeightSize = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xff582e44),
            width: WidthSize,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: HeightSize * 0.75,
                ),
                RaisedButton(
                  onPressed: () async {
                    nu = true;
                    await authServicer.updateVisisteurOrVendeur(true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                    );
                  },
                  textColor: Color(0xffE50914),
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    width: WidthSize * 0.75,
                    height: HeightSize * 0.08,
                    decoration: const BoxDecoration(
                        color: Color(0xffbd7344),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Center(
                      child: Text(
                        "عابر سبيل",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: WidthSize * (25 / 540),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: HeightSize * 0.02,
                ),
                RaisedButton(
                  onPressed: () async {
                    nu = false;
                    await authServicer.updateVisisteurOrVendeur(false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                    );
                  },
                  textColor: Color(0xffE50914),
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    width: WidthSize * 0.75,
                    height: HeightSize * 0.08,
                    decoration: const BoxDecoration(
                        color: Color(0xffbd7344),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Center(
                      child: Text(
                        "مطعم رحمة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: WidthSize * (25 / 540),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: WidthSize,
            child: Column(
              children: [
                SizedBox(
                  height: HeightSize * 0.15,
                ),
                Text(
                  'مرحبا بك',
                  style: TextStyle(
                    color: Color(0xff582e44),
                    fontSize: WidthSize * (40 / 540),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: HeightSize * 0.05,
                  ),
                  height: WidthSize * 0.3,
                  width: WidthSize * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/aber_sabel.png"),
                      )),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
