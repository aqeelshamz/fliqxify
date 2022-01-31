import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';

class LargeButton extends StatelessWidget {
  final Function onTap;
  final String label;
  const LargeButton({Key? key, required this.onTap, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        child: Text(
          label,
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        onPressed: () {
          onTap();
        },
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
        ),
      ),
    );
  }
}
