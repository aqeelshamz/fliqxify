import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/screens/get_started.dart';
import 'package:netflixclone/screens/home.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      getData();
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(),
              Image.asset("assets/images/textLogo.png", width: width * 0.7),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") == null) {
      Get.offAll(() => const GetStarted());
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .changeName(prefs.getString("name")!);
      Provider.of<UserProvider>(context, listen: false)
          .changeEmail(prefs.getString("email")!);
      Provider.of<UserProvider>(context, listen: false)
          .changeToken(prefs.getString("token")!);
      Get.offAll(() => const Home());
    }
  }
}
