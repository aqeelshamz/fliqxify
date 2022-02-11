import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/movie_player_provider.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';

class MovieVideoPlayer extends StatefulWidget {
  final String videoLink;
  const MovieVideoPlayer(this.videoLink, {Key? key}) : super(key: key);

  @override
  _MovieVideoPlayerState createState() => _MovieVideoPlayerState();
}

class _MovieVideoPlayerState extends State<MovieVideoPlayer> {
  BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    super.initState();
     BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
       widget.videoLink == ""
          ? "http://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8"
          : widget.videoLink,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController?.setupDataSource(dataSource);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(
          controller: _betterPlayerController!,
        ),
      ),
    );
  }
}
