import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String name = "";
  String email = "";
  String token = "";
  
  changeName(String newName){
    name = newName;
    notifyListeners();
  }

  changeEmail(String newEmail){
    email = newEmail;
    notifyListeners();
  }

  changeToken(String newToken){
    token = newToken;
    notifyListeners();
  }
}
