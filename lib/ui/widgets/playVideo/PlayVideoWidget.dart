import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String youtubeVideoId;
  VideoPlayerWidget(this.youtubeVideoId, {Key key}) : super(key: key);

  _VideoPlayerWidgetState createState() =>
      _VideoPlayerWidgetState(youtubeVideoId);
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  final String youtubeVideoId;
  _VideoPlayerWidgetState(this.youtubeVideoId);
  YoutubePlayerController _controller = YoutubePlayerController();
  void listener() {
    if (_controller.value.playerState == PlayerState.ended) {
      print("The Video is ended ");
    }
    if (mounted) {
      setState(() {
        print(_controller.value.playerState.toString());
        print(_controller.value.errorCode.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: YoutubePlayer(
          context: context,
          initialVideoId: youtubeVideoId,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            showVideoProgressIndicator: true,
          ),
          progressIndicatorColor: Colors.amber,
          
           progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
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
