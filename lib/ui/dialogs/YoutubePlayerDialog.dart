import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerDialog extends StatelessWidget {
  final String youtubeVideoId;
  YoutubePlayerDialog({
    @required this.youtubeVideoId,
  });
  YoutubePlayerController _controller = YoutubePlayerController();
  void listener() {
    if (_controller.value.playerState == PlayerState.ENDED) {
      print("The Video is ended ");
    }
    /*if (mounted) {
      setState(() {
        print(_controller.value.playerState.toString());
        print(_controller.value.errorCode.toString());
      });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: YoutubePlayer(
          context: context,
          videoId: youtubeVideoId,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            showVideoProgressIndicator: true,
          ),
          videoProgressIndicatorColor: Colors.cyan,
          progressColors: ProgressColors(
            playedColor: Colors.cyan,
            handleColor: Colors.cyanAccent,
          ),
          onPlayerInitialized: (controller) {
            _controller = controller;
            _controller.addListener(listener);
          },
        ),
      ),
    );
  }
}
