import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/thumbnail_card.dart';
import 'package:provider/provider.dart';

bool _searchingMovie = false;
String _keyword = "";

class SearchResults extends StatefulWidget {
  final String keyword;
  const SearchResults(this.keyword, {Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    searchMovie(widget.keyword);
    setState(() {
      _keyword = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(width * 0.04),
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (text) {
                  searchMovie(text);
                  setState(() {
                    _keyword = text;
                  });
                },
                decoration: InputDecoration(
                  fillColor: grey1,
                  filled: true,
                  hintText: "Search",
                  hintStyle: TextStyle(color: grey3),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: width * 0.04),
                  suffixIcon: _keyword == ""
                      ? const SizedBox.shrink()
                      : InkWell(onTap: () {
                          // _controller.clear();
                          setState(() {
                            _keyword = "";
                          });
                        }),
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
                    "Search results for",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    "\"${_keyword == "" ? widget.keyword : _keyword}\"",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: height * 0.04),
                  _searchingMovie
                      ? const Center(child: CircularProgressIndicator())
                      : Provider.of<MoviesProvider>(context)
                              .searchResult
                              .isEmpty
                          ? Column(children: [
                              SizedBox(height: height * 0.1),
                              Icon(
                                FeatherIcons.xCircle,
                                color: grey2,
                                size: width * 0.25,
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                "No results found.",
                                style: TextStyle(
                                  color: grey2,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ])
                          : GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 8 / 11,
                                      mainAxisSpacing: height * 0.015),
                              scrollDirection: Axis.vertical,
                              itemCount: Provider.of<MoviesProvider>(context)
                                  .searchResult
                                  .length,
                              itemBuilder: (context, index) {
                                return ThumbnailCard(
                                    movieId:
                                        Provider.of<MoviesProvider>(context)
                                            .searchResult[index]["id"]
                                            .toString(),
                                    heroId: "${index}mylist",
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w200" +
                                            Provider.of<MoviesProvider>(context)
                                                    .searchResult[index]
                                                ["poster_path"]);
                              },
                            ),
                ],
              )),
            ],
          ),
        ),
      ),
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

  void searchMovie(String keyword) async {
    setState(() {
      _searchingMovie = true;
    });

    await Provider.of<MoviesProvider>(context, listen: false)
        .searchMovie(keyword);

    setState(() {
      _searchingMovie = false;
    });
  }
}
