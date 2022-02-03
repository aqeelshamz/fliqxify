import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String name = "";
  String email = "";
  String token = "";

  changeName(String newName) {
    name = newName;
    notifyListeners();
  }

  changeEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  changeToken(String newToken) {
    token = newToken;
    notifyListeners();
  }

  logout() async {
    name = "";
    email = "";
    token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
