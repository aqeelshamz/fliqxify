import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/ForgotPassword/verify_email.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/text_box.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                    "Forgot Password",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              const TextBox(hintText: "Enter your email"),
              SizedBox(height: height * 0.02),
              LargeButton(
                onTap: () {
                  Get.off(() => const VerifyEmail());
                },
                label: "CONTINUE",
              )
            ],
          ),
        ),
      ),
    );
  }
}
