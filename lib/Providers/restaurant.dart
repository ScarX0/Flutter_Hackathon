import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Restaurant {
  String? id;
  String? name;
  String? restName;
  String? imgUrl;
  String? city;
  String? phone;
  String? commune;
  double? latitude;
  double? longitude;
  Map<String, dynamic>? menu;
  bool? needVol;
  int? volsNumber;
  bool? hasMenu;

  Restaurant(
      {required this.id,
      required this.name,
      required this.restName,
      required this.imgUrl,
      required this.city,
      required this.phone,
      required this.commune,
      required this.latitude,
      required this.longitude,
      required this.menu,
      required this.needVol,
      required this.volsNumber,
      required this.hasMenu});
}

class Restaurants extends ChangeNotifier {
  List<Restaurant> rests = [];

  Future<void> getRestaurants() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection('restaurants').get();

      final docs = data.docs;

      for (var element in docs) {}

      print(docs[2].data());
    } catch (e) {
      rethrow;
    }
  }
}
