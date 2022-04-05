import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
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
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCwLJDAJA_U5k1C2dRd_ZaM9sS-xgBj-oQ';

    try {
      final res = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': false
          }));

      final respond = await jsonDecode(res.body);

      if (res.statusCode == 200) {
        _token = respond['idToken'];
        _uId = respond['localId'];
        _expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(respond['expiresIn'])));

        notifyListeners();

        final pref = await SharedPreferences.getInstance();
        String userData = jsonEncode({
          'token': _token,
          'userId': _uId,
          'expiryDate': _expiryDate!.toIso8601String(),
        });

        pref.setString('userData', userData);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUser(String email, String phone, String name) async {
    Map<String, dynamic> data = {
      'id': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'isVolounteer': false
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    try {
      collectionReference.add(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  bool isVisiteur = false;

  updateVisisteurOrVendeur(bool X) async {
    isVisiteur = X;
    notifyListeners();
  }
}
