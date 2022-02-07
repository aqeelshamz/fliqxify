import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/signin.dart';
import 'package:netflixclone/screens/signup.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
              ),
              items: [
                "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/fliq.png",
                "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/posters_bg.png"
              ]
                  .map((item) => Container(
                        child: Center(
                            child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                          width: width,
                        )),
                      ))
                  .toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [black, transparent],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.2,
                      child: Center(
                        child: Image.asset(
                          "assets/images/textLogo.png",
                          width: width * 0.5,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                    width: width,
                    height: height * 0.6,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "ENDLESS\nENTERTAINMENT\nALL IN ONE PLACE.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
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
