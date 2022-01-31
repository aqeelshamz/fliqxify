import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:netflixclone/utils/colors.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FeatherIcons.chevronLeft,
        color: primaryColor,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }
}
