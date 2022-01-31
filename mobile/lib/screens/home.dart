import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:netflixclone/providers/bottom_navigation.dart';
import 'package:netflixclone/screens/pages/downloads.dart';
import 'package:netflixclone/screens/pages/home_page.dart';
import 'package:netflixclone/screens/pages/profile.dart';
import 'package:netflixclone/screens/pages/search.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    var bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: transparent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(),
        unselectedItemColor: grey2,
        currentIndex: bottomNavigationProvider.currentIndex,
        elevation: 0,
        selectedItemColor: primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.search,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.download,
              ),
              label: "Downloads"),
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.user,
              ),
              label: "Profile")
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              bottomNavigationProvider.changeIndex(index);
            },
            children: const [HomePage(), Search(), Downloads(), Profile()],
          ),
        ),
      ),
    );
  }
}