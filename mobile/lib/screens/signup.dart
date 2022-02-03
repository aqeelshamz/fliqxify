import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/plans.dart';
import 'package:netflixclone/screens/signin.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/link_button.dart';

bool _showPassword = false;

String _fullName = "";
String _email = "";
String _password = "";

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _fullName = "";
      _email = "";
      _password = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(width * 0.04),
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  const BackBtn(),
                  Text(
                    "Sign Up",
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
                  hintText: "Full name",
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
                    _fullName = txt;
                  });
                },
              ),
              SizedBox(height: height * 0.02),
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
                        !_showPassword ? FeatherIcons.eyeOff : FeatherIcons.eye,
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
              SizedBox(height: height * 0.02),
              Row(children: [
                Container(
                  width: width * 0.4,
                  height: height * 0.005,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: Colors.grey),
                  child: Row(
                    children: [
                      Container(
                        width: _password.length < 6 ? width * 0.05 : width * 0.4,
                        height: height * 0.005,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: _password.length < 6 ? errorRed : successGreen),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width * 0.02),
                Text(
                  _password.length < 6 ? "Bad" : "Excellent",
                  style: TextStyle(
                    color:  _password.length < 6 ? errorRed : successGreen,
                    fontWeight: FontWeight.w500,
                    fontSize: 11.5.sp,
                  ),
                ),
              ]),
              SizedBox(height: height * 0.02),
              Text(
                "Use a minimum of 6 characters (case sensitive) with at least one number of special character.",
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.5.sp,
                ),
              ),
              SizedBox(height: height * 0.04),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(value: true, onChanged: (x) {}),
                  Expanded(
                    child: Text(
                      "I would like to receive updates, special offers, and other information from Disney+ and The Walt Disney Family of Companies.",
                      style: TextStyle(
                          color: grey3,
                          fontWeight: FontWeight.w500,
                          fontSize: 11.5.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              LargeButton(
                  onTap: () {
                    if (_fullName == "") {
                      Fluttertoast.showToast(msg: "Enter Full Name");
                    } else if (!GetUtils.isEmail(_email)) {
                      Fluttertoast.showToast(msg: "Enter a valid email");
                    } else if (_password.length < 6) {
                      Fluttertoast.showToast(
                          msg: "Password must have atleast 6 characters");
                    } else {
                      Get.to(() => Plans(_fullName, _email, _password));
                    }
                  },
                  label: "CONTINUE"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                        color: white,
                        fontSize: 12.sp,
                      )),
                  LinkButton(
                    onTap: () {
                      Get.off(() => const SignIn());
                    },
                    label: "SIGN IN",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
