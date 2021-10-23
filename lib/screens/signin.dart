import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/ForgotPassword/forgot_password.dart';
import 'package:netflixclone/screens/home.dart';
import 'package:netflixclone/screens/signup.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/link_button.dart';
import 'package:netflixclone/widgets/text_box.dart';

bool _showPassword = false;

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
              const TextBox(hintText: "Email"),
              SizedBox(height: height * 0.02),
              TextBox(
                hintText: "Password",
                obscureText: !_showPassword,
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
              LargeButton(
                onTap: () {
                  Get.to(() => const Home());
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
}
