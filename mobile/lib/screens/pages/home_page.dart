import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/thumbnail_card.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

bool _loadingPopular = true;
bool _loadingTopRated = true;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getData();
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
              "Hi " + Provider.of<UserProvider>(context).name + " 👋",
              style: TextStyle(
                color: white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Welcome to Fliqxify.",
              style: TextStyle(
                color: white.withOpacity(0.6),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: height * 0.02),
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
              child: _loadingPopular
                  ? Container(
                      margin: EdgeInsets.only(right: width * 0.025),
                      height: height * 0.2,
                      child: const Center(child: CircularProgressIndicator()))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ThumbnailCard(
                            movieId: Provider.of<MoviesProvider>(context)
                                .popular[index]["id"]
                                .toString(),
                            heroId: "${index}mylist",
                            imageUrl: "https://image.tmdb.org/t/p/w200" +
                                Provider.of<MoviesProvider>(context)
                                    .popular[index]["poster_path"]);
                      },
                    ),
            ),
            SizedBox(height: height * 0.04),
            Text(
              "Top Rated",
              style: TextStyle(
                color: white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            SizedBox(
              height: height * 0.2,
              child: _loadingTopRated
                  ? Container(
                      margin: EdgeInsets.only(right: width * 0.025),
                      height: height * 0.2,
                      child: const Center(child: CircularProgressIndicator()))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ThumbnailCard(
                            movieId: Provider.of<MoviesProvider>(context)
                                .topRated[index]["id"]
                                .toString(),
                            heroId: "${index}tr",
                            imageUrl: "https://image.tmdb.org/t/p/w200" +
                                Provider.of<MoviesProvider>(context)
                                    .topRated[index]["poster_path"]);
                      },
                    ),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    ]);
  }

  void getData() async {
    setState(() {
      _loadingPopular = true;
      _loadingTopRated = true;
    });

    await Provider.of<MoviesProvider>(context, listen: false).getPopular();
    setState(() {
      _loadingPopular = false;
    });

    await Provider.of<MoviesProvider>(context, listen: false).getTopRated();
    setState(() {
      _loadingTopRated = false;
    });
  }
}
