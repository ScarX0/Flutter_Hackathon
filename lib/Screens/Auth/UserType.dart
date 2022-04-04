import 'package:abir_sabil/Screens/Auth/Signin.dart';
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
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xff4FBDBA),
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage("assets/auth_pic.png"),
              // )
            ),
          ),
          Container(
            width: WidthSize,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: HeightSize * 0.15,
                ),
                Text(
                  'مرحبا بك',
                  style: TextStyle(
                    color: Colors.white,
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    // image: DecorationImage(
                    //   fit: BoxFit.cover,
                    //   image: AssetImage("assets/auth_pic.png"),
                    // )
                  ),
                  child: Center(
                      child: Text(
                    "الشعار",
                    style: TextStyle(fontSize: WidthSize * (30 / 540)),
                  )),
                ),
                SizedBox(
                  height: HeightSize * 0.25,
                ),
                RaisedButton(
                  onPressed: () async {
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Center(
                      child: Text(
                        "عابر سبيل",
                        style: TextStyle(
                          color: Colors.black87,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Center(
                      child: Text(
                        "مطعم رحمة",
                        style: TextStyle(
                          color: Colors.black87,
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
          )
        ],
      ),
    );
  }
}
