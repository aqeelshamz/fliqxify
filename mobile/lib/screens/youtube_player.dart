import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String trailerUrl;

  const YouTubePlayerScreen(this.trailerUrl, {Key? key}) : super(key: key);

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.trailerUrl)!,
      flags:
          const YoutubePlayerFlags(autoPlay: true, mute: false, forceHD: true),
    );

    return WillPopScope(
      onWillPop: () async {
        if (_controller.value.isFullScreen) {
          _controller.toggleFullScreenMode();
          return false;
        }

        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: primaryColor,
                handleColor: primaryColor,
              ),
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                RemainingDuration(),
                FullScreenButton()
              ],
            ),
          )),
    );
  }
}
