import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:netflixclone/widgets/text_box.dart';
import 'package:netflixclone/widgets/thumbnail_card.dart';
import 'package:like_button/like_button.dart';

bool _showReviews = false;
bool _liked = false;

class MovieDetails extends StatefulWidget {
  final String posterImage;
  final String heroId;
  const MovieDetails(
      {Key? key, required this.heroId, required this.posterImage})
      : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    setState(() {
      _showReviews = false;
    });
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Stack(
          children: [
            Image.network(
              widget.posterImage,
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
        SafeArea(
          child: Column(children: [
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
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(width * 0.04),
                children: [
                  SizedBox(height: height * 0.05),
                  Row(
                    children: [
                      Hero(
                        tag: widget.heroId,
                        child: ThumbnailCard(
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
                            "8.2 IMDB",
                            style: TextStyle(
                              color: successGreen,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "Glow",
                            style: TextStyle(
                                color: white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "English",
                            style: TextStyle(
                              color: white,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            "2018",
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
                                        color: _liked ? primaryColor : white,
                                        size: 24.sp,
                                      );
                                    }),
                                SizedBox(height: height * 0.005),
                                Text(
                                  _liked ? "Liked" : "Like",
                                  style:
                                      TextStyle(color: white, fontSize: 12.sp),
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
                                  style:
                                      TextStyle(color: white, fontSize: 12.sp),
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
                                  style:
                                      TextStyle(color: white, fontSize: 12.sp),
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
                                  style:
                                      TextStyle(color: white, fontSize: 12.sp),
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
                    "A look at the personal and professional lives of a group of women who perform for a wrestling organization in Los Angeles during the 1980s.",
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
                            color: _showReviews ? transparent : primaryColor),
                      ),
                      Expanded(
                        child: Container(
                            height: 4,
                            color: _showReviews ? primaryColor : transparent),
                      ),
                    ],
                  ),
                  Divider(),
                  !_showReviews
                      ? Container(
                          width: width,
                          height: height * 0.25,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.circular(borderRadius * 2)),
                          child: Center(
                            child: InkWell(
                              onTap: () {},
                              child: Icon(FeatherIcons.playCircle,
                                  color: white, size: width * 0.2),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            TextBox(
                              prefixIcon: Icon(
                                FeatherIcons.edit2,
                                color: grey3,
                              ),
                              hintText: "Write a review..",
                            ),
                            SizedBox(height: height * 0.02),
                            Column(children: getReviews()),
                          ],
                        ),
                ],
              ),
            )
          ]),
        ),
      ],
    ));
  }

  getReviews() {
    List<Widget> widgets = [];
    for (int i = 1; i <= 10; i++) {
      widgets.add(
        Container(
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
                            "It's an awesome movie",
                            style: TextStyle(
                              color: white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      FeatherIcons.cornerUpLeft,
                                      color: white,
                                      size: 10.sp,
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Text(
                                      "Reply",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 7.sp,
                                      child: Icon(FeatherIcons.user,
                                          color: primaryColor, size: 7.sp),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Text(
                                      "1 Reply",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  FeatherIcons.heart,
                  color: white,
                  size: 14.sp,
                ),
                onPressed: () {},
              ),
            ],
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
}
