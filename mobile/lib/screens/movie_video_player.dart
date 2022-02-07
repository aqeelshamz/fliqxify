import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class MovieVideoPlayer extends StatefulWidget {
  final String videoLink;
  const MovieVideoPlayer(this.videoLink, {Key? key}) : super(key: key);

  @override
  _MovieVideoPlayerState createState() => _MovieVideoPlayerState();
}

class _MovieVideoPlayerState extends State<MovieVideoPlayer> {
  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          widget.videoLink == "" ?  "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4" : widget.videoLink),
    );
    flickManager?.flickDisplayManager?.handleVideoTap();
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlickVideoPlayer(
        flickManager: flickManager!,
        // flickVideoWithControls: FlickVideoWithControls(
        //   controls: LandscapePlayerControls(),
        // ),
      )),
    );
  }
}
