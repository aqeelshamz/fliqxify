import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  changePassword(String currentPassword, String newPassword) async {
    if (currentPassword == newPassword) {
      Fluttertoast.showToast(
          msg: "New password & Old password can't be the same",
          backgroundColor: errorRed,
          toastLength: Toast.LENGTH_LONG);
      return;
    }

    Map<String, String> headers = {
      "Authorization": "JWT $token",
      "Content-Type": "application/json"
    };

    Map<String, dynamic> body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": newPassword
    };

    var response = await http.post(
      Uri.parse("$serverURL/users/reset-password"),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Password changed!", backgroundColor: primaryColor);
      Get.back();
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: "Incorrect current password!", backgroundColor: errorRed);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong!", backgroundColor: errorRed);
    }
  }
}
