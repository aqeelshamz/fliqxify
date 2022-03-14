import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:provider/provider.dart';

String _currentPassword = "";
String _newPassword = "";

bool _showPassword = false;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
                    "Change Password",
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
                autofocus: true,
                obscureText: _showPassword,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "Current Password",
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
                onChanged: (e) {
                  setState(() {
                    _currentPassword = e;
                  });
                },
              ),
              SizedBox(height: height * 0.02),
              TextField(
                obscureText: _showPassword,
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "New Password",
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
                onChanged: (e) {
                  setState(() {
                    _newPassword = e;
                  });
                },
              ),
              SizedBox(height: height * 0.02),
              LargeButton(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .changePassword(_currentPassword, _newPassword);
                },
                label: "Change Password",
              )
            ],
          ),
        ),
      ),
    );
  }
}
