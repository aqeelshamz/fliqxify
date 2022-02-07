import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/thumbnail_card.dart';
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: 0,
            child: IgnorePointer(
              ignoring: true,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FeatherIcons.bell,
                ),
              ),
            ),
          ),
          Image.asset("assets/images/textLogo.png", width: width * 0.4),
          IconButton(
            onPressed: () {},
            icon: Stack(children: [
              Icon(
                FeatherIcons.bell,
                color: white,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: width * 0.025,
                  height: width * 0.025,
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                ),
              ),
            ]),
          ),
        ],
      ),
      SizedBox(height: height * 0.02),
      Expanded(
        child: RefreshIndicator(
          onRefresh: ()async{
            getData();
          },
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
              SizedBox(height: height * 0.04),
              Row(
                children: [
                  Icon(FeatherIcons.users, color: primaryColor),
                  SizedBox(width: width * 0.02),
                  Text(
                    "Popular",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              _loadingPopular
                  ? Container(
                      margin: EdgeInsets.only(right: width * 0.025),
                      height: height * 0.2,
                      child: const Center(child: CircularProgressIndicator()))
                  : GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 8 / 11,
                          mainAxisSpacing: height * 0.015),
                      scrollDirection: Axis.vertical,
                      itemCount:
                          Provider.of<MoviesProvider>(context).popular.length,
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
              SizedBox(height: height * 0.04),
              Row(
                children: [
                  Icon(FeatherIcons.star, color: primaryColor),
                  SizedBox(width: width * 0.02),
                  Text(
                    "Top Rated",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              _loadingTopRated
                  ? Container(
                      margin: EdgeInsets.only(right: width * 0.025),
                      height: height * 0.2,
                      child: const Center(child: CircularProgressIndicator()))
                  : GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 8 / 11,
                          mainAxisSpacing: height * 0.015),
                      scrollDirection: Axis.vertical,
                      itemCount:
                          Provider.of<MoviesProvider>(context).topRated.length,
                      itemBuilder: (context, index) {
                        return ThumbnailCard(
                            movieId: Provider.of<MoviesProvider>(context)
                                .topRated[index]["id"]
                                .toString(),
                            heroId: "${index}mylist",
                            imageUrl: "https://image.tmdb.org/t/p/w200" +
                                Provider.of<MoviesProvider>(context)
                                    .topRated[index]["poster_path"]);
                      },
                    ),
              SizedBox(height: height * 0.02),
            ],
          ),
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
