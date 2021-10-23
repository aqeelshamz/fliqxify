import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Text(
          "LOGO",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
      ),
      SizedBox(height: height * 0.02),
      Expanded(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "My List",
              style: TextStyle(
                color: white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: width * 0.025),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius * 2),
                      image: DecorationImage(
                          image: Image.network(
                                  "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/Rectangle%202.3%20(1).png")
                              .image,
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.04),
            Text(
              "Netflix Originals",
              style: TextStyle(
                color: white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: width * 0.025),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius * 2),
                      image: DecorationImage(
                          image: Image.network(
                                  "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/Rectangle%2019.png")
                              .image,
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.04),
            Text(
              "Trending now",
              style: TextStyle(
                color: white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: width * 0.025),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius * 2),
                      image: DecorationImage(
                          image: Image.network(
                            "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/Rectangle%202.3%20(2).png",
                          ).image,
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    ]);
  }
}
