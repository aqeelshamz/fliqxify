import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/text_box.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBox(
          hintText: "Search",
          prefixIcon: Icon(FeatherIcons.search, color: grey3),
        ),
        SizedBox(height: height * 0.04),
        Expanded(
            child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Category",
              style: TextStyle(
                color: white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.04),
            GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: (4 / 7),
                crossAxisCount: 3,
                children: getWidgets()),
          ],
        )),
      ],
    );
  }

  getWidgets() {
    List<Widget> widgets = [];
    for (int i = 1; i <= 9; i++) {
      widgets.add(Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: width * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius * 2),
                image: DecorationImage(
                    image: Image.network(
                      "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/Rectangle%202.3%20(2).png",
                    ).image,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Comedy",
            style: TextStyle(
              color: white,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: height * 0.03),
        ],
      ));
    }
    return widgets;
  }
}
