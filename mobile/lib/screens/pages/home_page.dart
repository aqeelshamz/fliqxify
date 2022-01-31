import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/general.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/thumbnail_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Image.asset("assets/images/textLogo.png", width: width * 0.4),
      ),
      SizedBox(height: height * 0.02),
      Expanded(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Popular",
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
                  return ThumbnailCard(
                      heroId: "${index}mylist",
                      imageUrl:
                          "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/Rectangle%202.3%20(1).png");
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
                  return ThumbnailCard(
                      heroId: "${index}or",
                      imageUrl:
                          "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/Rectangle%2019.png");
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
                  return ThumbnailCard(
                      heroId: "${index}tr",
                      imageUrl:
                          "https://raw.githubusercontent.com/aqeelshamz/projects-src/main/Rectangle%202.3%20(2).png");
                },
              ),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    ]);
  }

  getPopularMovies() async {
    var response =
        await http.get(Uri.parse("$tmdbUrl/movie/popular?api_key=$tmdbApiKey"));
    print(response.body);
  }
}
