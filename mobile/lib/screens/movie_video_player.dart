import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netflixclone/providers/movie_player_provider.dart';
import 'package:netflixclone/providers/movies.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';

class MovieVideoPlayer extends StatefulWidget {
  final String movieId;
  final String videoLink;
  const MovieVideoPlayer(this.movieId, this.videoLink, {Key? key})
      : super(key: key);

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
            fit: BoxFit.fitWidth,
            fullScreenByDefault: true,
            autoPlay: true,
            allowedScreenSleep: false,
            controlsConfiguration: const BetterPlayerControlsConfiguration(
              enablePlayPause: false,
              enableMute: true,
              enableFullscreen: false,
            ),
            startAt: Provider.of<MoviesProvider>(context, listen: false).playedMovies.contains(widget.movieId) ? Duration(
                hours: int.parse(Provider.of<MoviesProvider>(context, listen: false)
                    .continueWatching[Provider.of<MoviesProvider>(context, listen: false)
                        .playedMovies
                        .indexOf(widget.movieId)]["duration"].toString()
                    .split("#")[0]
                    .split(":")[0]),
                minutes: int.parse(Provider.of<MoviesProvider>(context, listen: false)
                    .continueWatching[Provider.of<MoviesProvider>(context, listen: false)
                        .playedMovies
                        .indexOf(widget.movieId)]["duration"].toString()
                    .split("#")[0]
                    .split(":")[1]),
                seconds: int.parse(Provider.of<MoviesProvider>(context, listen: false)
                    .continueWatching[Provider.of<MoviesProvider>(context, listen: false)
                        .playedMovies
                        .indexOf(widget.movieId)]["duration"].toString()
                    .split("#")[0]
                    .split(":")[2].split(".")[0])) : null);
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
    _betterPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var position =
            await _betterPlayerController?.videoPlayerController?.position;
        var totalDuration = _betterPlayerController
            ?.videoPlayerController?.bufferingConfiguration.maxBufferMs;
        Provider.of<MoviesProvider>(context, listen: false)
            .createContinueWatching(widget.movieId,
                "${position.toString()}#${totalDuration.toString()}");
        return true;
      },
      child: Scaffold(
        body: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(
            controller: _betterPlayerController!,
          ),
        ),
      ),
    );
  }
}
