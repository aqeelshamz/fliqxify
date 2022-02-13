import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/bottom_navigation.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/screens/change_password.dart';
import 'package:netflixclone/screens/get_started.dart';
import 'package:netflixclone/screens/settings.dart';
import 'package:netflixclone/screens/watchlist.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

bool _editUsername = false;
String _newUsername = "";

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    setState(() {
      _editUsername = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController? _usernameController;

    return ListView(
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
            icon: Icon(_editUsername ? FeatherIcons.check : FeatherIcons.edit2,
                color: white),
            onPressed: () {
              setState(() {
                _usernameController?.text =
                    Provider.of<UserProvider>(context, listen: false).name;
                _editUsername = !_editUsername;
              });
            },
          ),
          title: _editUsername
              ? TextField(
                  controller: _usernameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(color: grey2),
                  ),
                  onChanged: (txt) {
                    setState(() {
                      _newUsername = txt;
                    });
                  },
                )
              : Text(
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
          onTap: () {
            Get.to(()=> const WatchlistScreen());
          },
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
          onTap: () {
            Get.to(() => const ChangePassword());
          },
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
            Get.to(() => const Settings());
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
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: grey,
                    content: Text(
                      "Are you sure, want to log out?",
                      style: TextStyle(
                        color: white,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: white,
                          ),
                        ),
                        style: TextButton.styleFrom(backgroundColor: grey2),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<BottomNavigationProvider>(context,
                                  listen: false)
                              .changeIndex(0);
                          Provider.of<UserProvider>(context, listen: false)
                              .logout();
                          Get.offAll(() => const GetStarted());
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: white,
                          ),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: primaryColor),
                      ),
                    ],
                  );
                });
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

  void changeUsername() async {
    var response = await http.post(Uri.parse(""));
  }
}
