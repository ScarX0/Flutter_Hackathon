import 'package:abir_sabil/Screens/Auth/UserType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Providers/auth.dart';
import 'Screens/Auth/forgotPassword.dart';

void main() {
  Color primaryColor = Color(0xff072227);
  Color secondlyColor = Color(0xff35858B);
  Color thirdlyColor = Color(0xff4FBDBA);
  Color fourthColor = Color(0xffAEFEFF);

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
