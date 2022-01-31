import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/plans.dart';
import 'package:netflixclone/screens/signin.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/link_button.dart';
import 'package:netflixclone/widgets/text_box.dart';

bool _showPassword = false;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              const TextBox(
                hintText: "Full Name",
              ),
              SizedBox(height: height * 0.02),
              const TextBox(
                hintText: "Email",
              ),
              SizedBox(height: height * 0.02),
              TextBox(
                obscureText: !_showPassword,
                hintText: "Password",
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
              SizedBox(height: height * 0.02),
              Row(children: [
                Container(
                  width: width * 0.4,
                  height: height * 0.005,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: successGreen),
                ),
                SizedBox(width: width * 0.02),
                Text(
                  "Excellent",
                  style: TextStyle(
                    color: successGreen,
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
                    Get.to(() => const Plans());
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
