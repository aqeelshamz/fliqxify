import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/movie_details.dart';
import 'package:netflixclone/utils/size.dart';

class ThumbnailCard extends StatelessWidget {
  final String imageUrl;
  final String heroId;
  const ThumbnailCard({Key? key, required this.heroId, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> MovieDetails(heroId: heroId, posterImage: imageUrl,));
      },
      child: Container(
        margin: EdgeInsets.only(right: width * 0.025),
        width: width * 0.3,
        height: height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius * 2),
          image: DecorationImage(
              image: Image.network(
                      imageUrl)
                  .image,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
