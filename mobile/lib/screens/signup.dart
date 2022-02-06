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
bool _showConfirmPassword = false;

String _fullName = "";
String _email = "";
String _password = "";
String _confirmPassword = "";

bool _policyUpdates = true;

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
      _confirmPassword = "";
      _showPassword = false;
      _showConfirmPassword = false;
      _policyUpdates = true;
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
              SizedBox(height: height * 0.02),
              TextField(
                obscureText: !_showConfirmPassword,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: grey3),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: width * 0.04),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _showConfirmPassword
                            ? FeatherIcons.eyeOff
                            : FeatherIcons.eye,
                        color: grey3),
                    onPressed: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
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
                    _confirmPassword = txt;
                  });
                },
              ),
              SizedBox(height: height * 0.02),
              _password.isNotEmpty
                  ? Row(children: [
                      Container(
                        width: width * 0.4,
                        height: height * 0.005,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: grey1),
                        child: Row(
                          children: [
                            Container(
                              width: width * getPasswordStrength()[1],
                              height: height * 0.005,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  color: getPasswordStrength()[2]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        getPasswordStrength()[0],
                        style: TextStyle(
                          color: getPasswordStrength()[2],
                          fontWeight: FontWeight.w500,
                          fontSize: 11.5.sp,
                        ),
                      ),
                    ])
                  : const SizedBox.shrink(),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                      value: _policyUpdates,
                      onChanged: (x) {
                        setState(() {
                          _policyUpdates = x!;
                        });
                      }),
                  Expanded(
                    child: Text(
                      "I would like to receive updates, special offers, and other information from Fliqxify.",
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
                    } else if (getPasswordStrength()[1] < 0.3) {
                      Fluttertoast.showToast(msg: "Create a strong password");
                    } else if (_password != _confirmPassword) {
                      Fluttertoast.showToast(msg: "Passwords don't match");
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

  List getPasswordStrength() {
    List tooShort = ["Too Short", 0.1, Colors.red];
    List weak = ["Weak", 0.2, Colors.orange[800]];
    List strong = ["Strong", 0.3, Colors.green];
    List great = ["Great", 0.4, Colors.green];

    if (_password.length < 6) {
      return tooShort;
    }

    RegExp numReg = RegExp(r".*[0-9].*");
    RegExp letterReg = RegExp(r".*[A-Za-z].*");
    RegExp specialReg = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!numReg.hasMatch(_password) ||
        !letterReg.hasMatch(_password) ||
        !specialReg.hasMatch(_password)) {
      return weak;
    }

    if (_password.length <= 10) {
      return strong;
    }

    return great;
  }
}
