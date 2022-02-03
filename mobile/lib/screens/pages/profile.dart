import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/bottom_navigation.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/screens/get_started.dart';
import 'package:netflixclone/screens/settings.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile",
          style: TextStyle(
            color: white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: width * 0.13,
                child: Icon(
                  FeatherIcons.user,
                  color: primaryColor,
                  size: width * 0.1,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: width * 0.1,
                  height: width * 0.1,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FeatherIcons.camera,
                    color: white,
                    size: width * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.04,
        ),
        ListTile(
          leading: Icon(FeatherIcons.user, color: white),
          trailing: IconButton(
            icon: Icon(FeatherIcons.edit2, color: white),
            onPressed: () {},
          ),
          title: Text(
            Provider.of<UserProvider>(context).name,
            style: TextStyle(
              color: white,
              fontSize: 15.sp,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        ListTile(
          leading: Icon(FeatherIcons.atSign, color: white),
          title: Text(
            Provider.of<UserProvider>(context).email,
            style: TextStyle(
              color: white,
              fontSize: 15.sp,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        ListTile(
          onTap: () {},
          leading: Icon(FeatherIcons.tv, color: white),
          trailing: Icon(FeatherIcons.chevronRight, color: white),
          title: Text(
            "My Watchlist",
            style: TextStyle(
              color: white,
              fontSize: 15.sp,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        ListTile(
          onTap: () {},
          leading: Icon(FeatherIcons.lock, color: white),
          trailing: Icon(FeatherIcons.chevronRight, color: white),
          title: Text(
            "Change Password",
            style: TextStyle(
              color: white,
              fontSize: 15.sp,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        ListTile(
          onTap: () {
            Get.to(()=>const Settings());
          },
          leading: Icon(FeatherIcons.settings, color: white),
          trailing: Icon(FeatherIcons.chevronRight, color: white),
          title: Text(
            "Settings",
            style: TextStyle(
              color: white,
              fontSize: 15.sp,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        ListTile(
          onTap: () {
            Provider.of<BottomNavigationProvider>(context, listen: false).changeIndex(0);
            Get.offAll(() => const GetStarted());
          },
          leading: Icon(FeatherIcons.logOut, color: white),
          trailing: Icon(FeatherIcons.chevronRight, color: white),
          title: Text(
            "Log out",
            style: TextStyle(
              color: white,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }
}
