import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';

bool _showPassword = false;

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(width * 0.04),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackBtn(),
                  Text(
                    "Reset Password",
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
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "New password",
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
                  prefixIcon: Icon(FeatherIcons.search, color: grey3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: white,
                  fontSize: 15.sp,
                ),
                onChanged: (e) {},
              ),
              SizedBox(height: height * 0.02),
              TextField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "New password",
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
                  prefixIcon: Icon(FeatherIcons.search, color: grey3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: white,
                  fontSize: 15.sp,
                ),
                onChanged: (e) {},
              ),
              TextField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "Confirm password",
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
                  prefixIcon: Icon(FeatherIcons.search, color: grey3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: white,
                  fontSize: 15.sp,
                ),
                onChanged: (e) {},
              ),
              SizedBox(height: height * 0.02),
              LargeButton(
                onTap: () {
                  Get.back();
                },
                label: "RESET PASSWORD",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
