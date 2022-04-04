import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  bool isVisiteur = false;

  updateVisisteurOrVendeur(bool X) async {
    isVisiteur = X;
    notifyListeners();
  }
}
