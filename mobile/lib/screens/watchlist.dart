import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/screens/movie_details.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/languages.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

bool _loading = false;
List watchlist = [];

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    setState(() {
      watchlist = [];
      _loading = false;
    });
    getWatchlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(width * 0.04),
        child: SafeArea(
          child: Column(
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
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text(
                    "My Watchlist",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: watchlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => MovieDetails(
                                  movieId: watchlist[index]["id"].toString(),
                                  heroId: watchlist[index]["id"].toString(),
                                  posterImage:
                                      "https://image.tmdb.org/t/p/w200" +
                                          watchlist[index]["poster_path"]
                                              .toString(),
                                ),
                              );
                            },
                            borderRadius:
                                BorderRadius.circular(borderRadius * 2),
                            child: Container(
                              padding: EdgeInsets.all(width * 0.04),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(borderRadius * 2),
                                    child: Image.network(
                                        "https://image.tmdb.org/t/p/w200" +
                                            watchlist[index]["poster_path"]
                                                .toString(),
                                        width: width * 0.3,
                                        height: height * 0.2,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: width * 0.04),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          watchlist[index]["vote_average"]
                                                  .toString() +
                                              " IMDB",
                                          style: TextStyle(
                                            color: successGreen,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          watchlist[index]["title"].toString(),
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          languages[watchlist[index]
                                                  ["original_language"]]
                                              .toString(),
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getWatchlist() async {
    setState(() {
      _loading = true;
    });
    Map<String, String> headers = {
      "Authorization":
          "JWT ${Provider.of<UserProvider>(context, listen: false).token}",
      "Content-Type": "application/json"
    };

    var response = await http.get(
      Uri.parse("$serverURL/movies/my-watchlist"),
      headers: headers,
    );

    setState(() {
      watchlist = jsonDecode(response.body);
      _loading = false;
    });
  }
}
