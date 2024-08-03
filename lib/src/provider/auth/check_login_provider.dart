import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';

class CheckLoginProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    bool isLogged = await sharedPrefs.getBoolPref('logged') ?? false;
    _isLoggedIn = isLogged;
    notifyListeners();
  }

  void setLoggedIn(bool loggedIn) {
    _isLoggedIn = loggedIn;
    notifyListeners();
  }
}
