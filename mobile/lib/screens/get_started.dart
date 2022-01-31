import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/signin.dart';
import 'package:netflixclone/screens/signup.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/widgets/large_button.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(
              "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/posters_bg.png",
            ).image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        width: width,
        height: height,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: width,
                    height: height * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [black, transparent],
                      ),
                    )),
                Container(
                    width: width,
                    height: height * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [black, transparent],
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LargeButton(
                    onTap: () {
                      Get.to(() => const SignUp());
                    },
                    label: "GET STARTED",
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    width: width,
                    child: TextButton(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => const SignIn());
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
