import 'dart:convert';

import 'package:abir_sabil/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool googleSignedIn = false;
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  String? _token;
  String? _uId;
  DateTime? _expiryDate;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String? get uId {
    return _uId;
  }

  Future<void> googleLogIn() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      // _token = googleAuth.idToken;
      // _uId = googleAuth.accessToken;

      // final pref = await SharedPreferences.getInstance();
      // String userData = jsonEncode({
      //   'token': _token,
      //   'userId': _uId,
      //   'expiryDate': _expiryDate!.toIso8601String(),
      // });

      // pref.setString('userData', userData);

      googleSignedIn = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password, String name, String phone,
      String restName) async {
    String where = isVisiteur ? 'volounteers' : 'restaurants';
    var data = isVisiteur
        ? {'name': name, 'email': email, 'phone': phone, 'isVolounteer': false}
        : {
            'name': name,
            'email': email,
            'phone': phone,
            'restaurantName': restName,
            'photo': '',
            'city': '',
            'location': [],
            'hasMenu': false
          };
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(where);
      final auth = FirebaseAuth.instance;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => collectionReference.doc(value.user!.uid).set(data));
      // final res = await http.post(Uri.parse(url),
      //     headers: {'Content-Type': 'application/json'},
      //     body: jsonEncode({
      //       'email': email,
      //       'password': password,
      //       'returnSecureToken': false
      //     }));

      // final respond = await jsonDecode(res.body);

      // if (res.statusCode == 200) {
      //   _token = respond['idToken'];
      //   _uId = respond['localId'];
      //   _expiryDate = DateTime.now()
      //       .add(Duration(seconds: int.parse(respond['expiresIn'])));

      //   notifyListeners();

      //   final pref = await SharedPreferences.getInstance();
      //   String userData = jsonEncode({
      //     'token': _token,
      //     'userId': _uId,
      //     'expiryDate': _expiryDate!.toIso8601String(),
      //   });

      //   pref.setString('userData', userData);
      // }
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> userInfo = {
    'name': '',
    'email': '',
    'phone': '',
    'isVlounteer': false,
    'location': [0.0, 0.0],
    'city': '',
    'hasMenu': false,
    'image': '',
  };
  // bool s = nu;

  Future<void> getUserInfos() async {
    try {
      final auth = FirebaseAuth.instance.currentUser;
      final where = nu ? 'volounteers' : 'restaurants';
      final user = await FirebaseFirestore.instance
          .collection(where)
          .doc(auth!.uid)
          .get();
      userInfo = user.data()!;
      print(userInfo);
      print(user.data());
      if (nu) {
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => print('not assured' + value.user!.email!));

      final auth2 = FirebaseAuth.instance;

      print('assured' + auth2.currentUser!.email!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUser(
      String email, String phone, String name, String restName) async {
    String where = isVisiteur ? 'volounteers' : 'restaurants';
    // final user = FirebaseAuth.instance.currentUser!;

    Map<String, dynamic> data = isVisiteur
        ? {
            'id': _uId,
            'name': name,
            'email': email,
            'phone': phone,
            'isVolounteer': false
          }
        : {
            'id': _uId,
            'name': name,
            'email': email,
            'phone': phone,
            'restaurantName': restName,
            'photo': '',
            'city': '',
            'location': '',
          };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(where);
    try {
      await collectionReference.doc(_uId).set(data);
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> signIn(String email, String password) async {
  //   _authenticate(email, password, 'signInWithPassword');
  // }

  // Future<void> signUp(String email, String password) async {
  //   _authenticate(email, password, 'signUp');
  // }

  bool isVisiteur = false;

  updateVisisteurOrVendeur(bool X) async {
    isVisiteur = X;
    notifyListeners();
  }
}
