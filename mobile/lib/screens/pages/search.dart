import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/screens/pages/search/search_results.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (text) {
            Get.to(() => SearchResults(text));
          },
          obscureText: false,
          decoration: InputDecoration(
            fillColor: grey1,
            filled: true,
            hintText: "Search",
            hintStyle: TextStyle(color: grey3),
            contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
            suffixIcon: null,
            prefixIcon: Icon(FeatherIcons.search, color: grey3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(
            color: white,
            fontSize: 15.sp,
          ),
          onChanged: (e) {},
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
    for (int i = 0;
        i <
            Provider.of<MoviesProvider>(Get.context!, listen: false)
                .categories
                .length;
        i++) {
      widgets.add(Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: width * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius * 2),
                image: DecorationImage(
                    image: Image.network(
                      Provider.of<MoviesProvider>(Get.context!, listen: false)
                          .categories[i]["image"],
                    ).image,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            Provider.of<MoviesProvider>(Get.context!, listen: false)
                .categories[i]["name"],
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
