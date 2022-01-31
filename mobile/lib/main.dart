import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflixclone/providers/bottom_navigation.dart';
import 'package:netflixclone/screens/splash_screen.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomNavigationProvider>(
              create: (_) => BottomNavigationProvider())
        ],
        child: Builder(
          builder: (context) => GetMaterialApp(
            home: const SplashScreen(),
            color: primaryColor,
            theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              primarySwatch: Colors.orange,
            ).copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(),
              primaryColor: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
