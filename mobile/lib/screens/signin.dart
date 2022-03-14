import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/screens/ForgotPassword/forgot_password.dart';
import 'package:netflixclone/screens/home.dart';
import 'package:netflixclone/screens/signup.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/link_button.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _showPassword = false;
String _email = "";
String _password = "";

bool _loading = false;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(width * 0.04),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const BackBtn(),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "Email",
                  hintStyle: TextStyle(color: grey3),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: width * 0.04),
                  suffixIcon: null,
                  prefixIcon: null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: white,
                  fontSize: 15.sp,
                ),
                onChanged: (txt) {
                  setState(() {
                    _email = txt;
                  });
                },
              ),
              SizedBox(height: height * 0.02),
              TextField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "Password",
                  hintStyle: TextStyle(color: grey3),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: width * 0.04),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _showPassword ? FeatherIcons.eyeOff : FeatherIcons.eye,
                        color: grey3),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  prefixIcon: null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: white,
                  fontSize: 15.sp,
                ),
                onChanged: (txt) {
                  setState(() {
                    _password = txt;
                  });
                },
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.off(() => const ForgotPassword());
                    },
                    child: Text(
                      "Forgot password",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : LargeButton(
                      onTap: () {
                        login();
                      },
                      label: "SIGN IN",
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                    ),
                  ),
                  LinkButton(
                    onTap: () {
                      Get.off(() => const SignUp());
                    },
                    label: "SIGN UP",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      _loading = true;
    });
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map<String, dynamic> body = {"email": _email, "password": _password};

    var response = await http.post(Uri.parse("$serverURL/users/login"),
        headers: headers, body: jsonEncode(body));

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Signed In!", backgroundColor: primaryColor);
      var data = jsonDecode(response.body);
      Provider.of<UserProvider>(context, listen: false).changeName(data["name"]);
      Provider.of<UserProvider>(context, listen: false).changeEmail(data["email"]);
      Provider.of<UserProvider>(context, listen: false).changeToken(data["token"]);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("name", data["name"]);
      prefs.setString("email", data["email"]);
      prefs.setString("token", data["token"]);
      Get.offAll(() => const Home());
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: "Incorrect email or password", backgroundColor: errorRed);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong", backgroundColor: errorRed);
    }
  }
}
