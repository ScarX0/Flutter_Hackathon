import 'package:abir_sabil/Screens/Auth/UserType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Providers/auth.dart';
import 'Screens/Auth/forgotPassword.dart';
import 'Screens/profile.dart';

void main() {
  Color primaryColor = Color(0xffbd7344);
  Color secondlyColor = Color(0xffa8293c);
  Color thirdlyColor = Color(0xff582e44);
  Color fourthColor = Color(0xff8e7a3d);
  Color fivethcolor = Color(0xffd7b957);


  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ListenableProvider<AuthService>(
        create: (_) => AuthService(),
      ),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: UserType() // signin()
        ),
  ));
}
