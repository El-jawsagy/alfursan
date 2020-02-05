import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class YoutubeDisplay extends StatefulWidget {


  final String title;

  YoutubeDisplay(this.title);

  @override
  _YoutubeDisplayState createState() => _YoutubeDisplayState();
}

class _YoutubeDisplayState extends State<YoutubeDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: FlutterYoutube.playYoutubeVideoByUrl(
            apiKey: "<API_KEY>",
            videoUrl: "https://www.youtube.com/watch?v=FfTrbKtnvTo",
            autoPlay: true, //default falase
            fullScreen: false,
          //default false
        )



    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


}