import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/screens/youtube_player.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/languages.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/thumbnail_card.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

bool _showReviews = false;
bool _liked = false;
bool _loading = true;
bool _loadingTrailer = true;
bool _postingReview = false;
bool _loadingReviews = false;

Map trailer = {};

String _reviewText = "";
TextEditingController _reviewTextController = TextEditingController();

List reviews = [];

int _selectedReview = -1;

class MovieDetails extends StatefulWidget {
  final String movieId;
  final String posterImage;
  final String heroId;
  const MovieDetails(
      {Key? key,
      required this.movieId,
      required this.heroId,
      required this.posterImage})
      : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with TickerProviderStateMixin {
  @override
  void initState() {
    setState(() {
      _showReviews = false;
    });
    getData();
    getReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Stack(
          children: [
            Image.network(
              widget.posterImage.replaceAll("w200", "original"),
              width: width,
              height: height * 0.3,
              fit: BoxFit.cover,
            ),
            Container(
              width: width,
              height: height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [backgroundColor, transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
        Column(children: [
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(width * 0.04),
                    children: [
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              FeatherIcons.arrowLeft,
                              color: white,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.05),
                      Row(
                        children: [
                          Hero(
                            tag: widget.heroId,
                            child: ThumbnailCard(
                                movieId: widget.movieId,
                                heroId: widget.heroId,
                                imageUrl: widget.posterImage),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Provider.of<MoviesProvider>(context)
                                        .movieDetails["vote_average"]
                                        .toString() +
                                    " IMDB",
                                style: TextStyle(
                                  color: successGreen,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.55,
                                child: Text(
                                  Provider.of<MoviesProvider>(context)
                                      .movieDetails["title"],
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                languages[Provider.of<MoviesProvider>(context)
                                    .movieDetails["original_language"]],
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                Provider.of<MoviesProvider>(context)
                                    .movieDetails["release_date"]
                                    .toString()
                                    .split("-")[0],
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      LargeButton(onTap: () {}, label: "PLAY"),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(borderRadius),
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Column(
                                  children: [
                                    LikeButton(
                                        onTap: onLikeButtonTapped,
                                        likeBuilder: (isLiked) {
                                          return Icon(
                                            _liked
                                                ? Icons.favorite
                                                : FeatherIcons.heart,
                                            color:
                                                _liked ? primaryColor : white,
                                            size: 24.sp,
                                          );
                                        }),
                                    SizedBox(height: height * 0.005),
                                    Text(
                                      _liked ? "Liked" : "Like",
                                      style: TextStyle(
                                          color: white, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(borderRadius),
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Column(
                                  children: [
                                    Icon(FeatherIcons.plus,
                                        color: white, size: 24.sp),
                                    SizedBox(height: height * 0.005),
                                    Text(
                                      "My List",
                                      style: TextStyle(
                                          color: white, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(borderRadius),
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Column(
                                  children: [
                                    Icon(FeatherIcons.download,
                                        color: white, size: 24.sp),
                                    SizedBox(height: height * 0.005),
                                    Text(
                                      "Download",
                                      style: TextStyle(
                                          color: white, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(borderRadius),
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Column(
                                  children: [
                                    Icon(FeatherIcons.share,
                                        color: white, size: 24.sp),
                                    SizedBox(height: height * 0.005),
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                          color: white, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        Provider.of<MoviesProvider>(context)
                            .movieDetails["overview"],
                        style: TextStyle(
                          color: white,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      Row(
                        children: [
                          Expanded(
                              child: TextButton(
                            child: Text(
                              "Watch Trailer",
                              style: TextStyle(
                                color: _showReviews ? white : primaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _showReviews = false;
                              });
                            },
                          )),
                          Expanded(
                              child: TextButton(
                            child: Text(
                              "Reviews",
                              style: TextStyle(
                                color: _showReviews ? primaryColor : white,
                                fontSize: 14.sp,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _showReviews = true;
                              });
                            },
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 4,
                                color:
                                    _showReviews ? transparent : primaryColor),
                          ),
                          Expanded(
                            child: Container(
                                height: 4,
                                color:
                                    _showReviews ? primaryColor : transparent),
                          ),
                        ],
                      ),
                      const Divider(),
                      !_showReviews
                          ? _loadingTrailer
                              ? SizedBox(
                                  height: height * 0.25,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                )
                              : Container(
                                  width: width,
                                  height: height * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      borderRadius * 2,
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          trailer["thumbnail"].toString(),
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => YouTubePlayerScreen(
                                            trailer["url"].toString()));
                                      },
                                      child: Icon(FeatherIcons.playCircle,
                                          color: white, size: width * 0.2),
                                    ),
                                  ),
                                )
                          : Column(
                              children: [
                                TextField(
                                  controller: _reviewTextController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    fillColor: grey1,
                                    filled: true,
                                    hintText: "Write a review...",
                                    hintStyle: TextStyle(color: grey3),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04),
                                    suffixIcon: _postingReview
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    "Posting...",
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : _reviewText.isEmpty
                                            ? const SizedBox.shrink()
                                            : IconButton(
                                                icon: const Icon(
                                                    FeatherIcons.send),
                                                onPressed: () {
                                                  postReview();
                                                }),
                                    prefixIcon: Icon(
                                      FeatherIcons.edit2,
                                      color: grey3,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(borderRadius),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 15.sp,
                                  ),
                                  onChanged: (txt) {
                                    setState(() {
                                      _reviewText = txt;
                                    });
                                  },
                                ),
                                SizedBox(height: height * 0.02),
                                reviews.isEmpty
                                    ? SizedBox(
                                        height: height * 0.1,
                                        child: Center(
                                            child: Text(
                                          "No Reviews",
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 15.sp,
                                          ),
                                        )),
                                      )
                                    : Column(children: getReviewWidgets()),
                              ],
                            ),
                    ],
                  ),
          )
        ]),
      ],
    ));
  }

  getReviewWidgets() {
    List<Widget> widgets = [];
    for (int i = 0; i < reviews.length; i++) {
      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              _selectedReview = -1;
            });
          },
          onLongPress: () {
            if (reviews[i]["email"] ==
                Provider.of<UserProvider>(context, listen: false).email) {
              setState(() {
                _selectedReview = i;
              });
            }
          },
          child: Container(
            color: _selectedReview == i ? primaryColor.withOpacity(0.5) : null,
            padding: EdgeInsets.all(width * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          FeatherIcons.user,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviews[i]["username"],
                              style: TextStyle(
                                color: white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              reviews[i]["review"],
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
                _selectedReview == i
                    ? InkWell(
                        onTap: () {
                          deleteReview(reviews[i]["_id"]);
                        },
                        child: Icon(
                          FeatherIcons.trash,
                          color: white,
                          size: 14.sp,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              likeReview(reviews[i]["_id"]);
                            },
                            child: Icon(
                              reviews[i]["likes"].contains(
                                      Provider.of<UserProvider>(context).email)
                                  ? Icons.favorite
                                  : FeatherIcons.heart,
                              color: reviews[i]["likes"].contains(
                                      Provider.of<UserProvider>(context).email)
                                  ? errorRed
                                  : white,
                              size: 14.sp,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            reviews[i]["likes"].length.toString(),
                            style: TextStyle(
                              color: white.withOpacity(0.8),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    setState(() {
      _liked = !_liked;
    });
    return _liked;
  }

  void getData() async {
    setState(() {
      _loading = true;
      _loadingTrailer = true;
    });

    await Provider.of<MoviesProvider>(context, listen: false)
        .getMovieDetails(widget.movieId);

    setState(() {
      _loading = false;
    });

    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, dynamic> body = {"movieId": widget.movieId};
    var response = await http.post(
      Uri.parse("$serverURL/movies/trailer"),
      headers: headers,
      body: jsonEncode(body),
    );
    trailer = jsonDecode(response.body);

    setState(() {
      _loadingTrailer = false;
    });
  }

  void postReview() async {
    setState(() {
      _postingReview = true;
    });
    Map<String, String> headers = {
      "Authorization":
          "JWT ${Provider.of<UserProvider>(context, listen: false).token}",
      "Content-Type": "application/json"
    };
    Map<String, dynamic> body = {
      "movieId": widget.movieId,
      "review": _reviewText
    };

    var response = await http.post(
      Uri.parse("$serverURL/movies/post-review"),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Review Posted", backgroundColor: primaryColor);
      _reviewTextController.clear();
      setState(() {
        _reviewText = "";
      });
      getReviews();
    } else {
      Fluttertoast.showToast(
          msg: "Failed to post review", backgroundColor: errorRed);
    }

    setState(() {
      _postingReview = false;
    });
  }

  void getReviews() async {
    setState(() {
      _loadingReviews = true;
    });
    Map<String, String> headers = {
      "Authorization":
          "JWT ${Provider.of<UserProvider>(context, listen: false).token}",
      "Content-Type": "application/json"
    };
    Map<String, dynamic> body = {
      "movieId": widget.movieId,
    };

    var response = await http.post(
      Uri.parse("$serverURL/movies/get-reviews"),
      headers: headers,
      body: jsonEncode(body),
    );

    setState(() {
      reviews = jsonDecode(response.body);
      _loadingReviews = false;
    });
  }

  void likeReview(String reviewId) async {
    Map<String, String> headers = {
      "Authorization":
          "JWT ${Provider.of<UserProvider>(context, listen: false).token}",
      "Content-Type": "application/json"
    };
    Map<String, dynamic> body = {
      "reviewId": reviewId,
    };

    var response = await http.post(
      Uri.parse("$serverURL/movies/like"),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      getReviews();
    }
  }

  void deleteReview(String reviewId) async {
    Fluttertoast.showToast(
        msg: "Deleting review..", backgroundColor: primaryColor);

    Map<String, String> headers = {
      "Authorization":
          "JWT ${Provider.of<UserProvider>(context, listen: false).token}",
      "Content-Type": "application/json"
    };
    Map<String, dynamic> body = {
      "reviewId": reviewId,
    };

    var response = await http.post(
      Uri.parse("$serverURL/movies/delete-review"),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      setState(() {
        _selectedReview = -1;
      });
      Fluttertoast.showToast(
          msg: "Review deleted!", backgroundColor: primaryColor);
      getReviews();
    }
  }
}
