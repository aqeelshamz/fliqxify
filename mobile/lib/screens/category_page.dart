import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/widgets/thumbnail_card.dart';
import 'package:provider/provider.dart';

bool _loading = false;

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  const CategoryPage(this.categoryName, this.categoryId, {Key? key})
      : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      FeatherIcons.chevronLeft,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    widget.categoryName,
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 8 / 11,
                            mainAxisSpacing: height * 0.015),
                        scrollDirection: Axis.vertical,
                        itemCount: Provider.of<MoviesProvider>(context)
                            .categoryMovies
                            .length,
                        itemBuilder: (context, index) {
                          return ThumbnailCard(
                              movieId: Provider.of<MoviesProvider>(context)
                                  .categoryMovies[index]["id"]
                                  .toString(),
                              heroId: "${index}mylist",
                              imageUrl: "https://image.tmdb.org/t/p/w200" +
                                  Provider.of<MoviesProvider>(context)
                                      .categoryMovies[index]["poster_path"]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getMovies() async {
    setState(() {
      _loading = true;
    });

    await Provider.of<MoviesProvider>(context, listen: false)
        .getMoviesByCategory(widget.categoryId);

    setState(() {
      _loading = false;
    });
  }
}
