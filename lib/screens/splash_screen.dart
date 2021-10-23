import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/get_started.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const GetStarted());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGO",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 40,
                ),
              ),
              CircularProgressIndicator(color: grey),
            ],
          ),
        ),
      ),
    );
  }
}
