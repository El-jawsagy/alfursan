import 'package:al_fursan/gallery/images_gallery/Images_screen.dart';
import 'package:al_fursan/gallery/videos_gallery/all_videos_screen.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GalleryScreen extends StatefulWidget {
  bool language;

  GalleryScreen(this.language);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.language ? "المعرض" : "Gallery",
            style: TextStyle(
              fontFamily: 'elmessiri',
              letterSpacing: 1.1,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(FontAwesomeIcons.image)),
              Tab(icon: Icon(FontAwesomeIcons.video)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ImagesScreen(widget.language),
            VideosScreen(widget.language),
          ],
        ),
      ),
    );
  }
}
