import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';

class TextBox extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  const TextBox(
      {Key? key, this.hintText = "", this.prefixIcon, this.suffixIcon, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: grey1,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: grey3),
        contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(
        color: white,
        fontSize: 15.sp,
      ),
    );
  }
}
