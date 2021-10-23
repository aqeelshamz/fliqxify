import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkButton extends StatelessWidget {
  final Function onTap;
  final String label;
  const LinkButton({Key? key, required this.onTap, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
      onPressed: () {
        onTap();
      },
    );
  }
}
