import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/screens/get_started.dart';
import 'package:netflixclone/screens/home.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
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
    var response = await http.get(Uri.parse("$serverURL/status"));
    if (response.body != "free") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: grey,
              content: Text(
                response.body,
                style: TextStyle(
                  color: white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Provider.of<UserProvider>(context, listen: false).logout();
                    Get.back();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: primaryColor),
                ),
              ],
            );
          });
      Get.back();
    }
    await Provider.of<MoviesProvider>(context, listen: false).getPopular();
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
