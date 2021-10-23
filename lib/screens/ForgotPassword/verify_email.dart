import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/ForgotPassword/reset_password.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/link_button.dart';
import 'package:netflixclone/widgets/text_box.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
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
                    "Verify Email",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Text(
                "A verification code has been sent to your email.",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.5.sp,
                ),
              ),
              SizedBox(height: height * 0.02),
              const TextBox(hintText: "Enter verification code"),
              SizedBox(height: height * 0.02),
              LargeButton(
                onTap: () {
                  Get.off(() => const ResetPassword());
                },
                label: "VERIFY",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                    ),
                  ),
                  LinkButton(
                    onTap: () {},
                    label: "Resend code",
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
