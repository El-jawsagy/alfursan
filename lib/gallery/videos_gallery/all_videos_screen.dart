import 'package:al_fursan/gallery/images_gallery/gallery_image_api.dart';
import 'package:al_fursan/gallery/videos_gallery/gallery_videos_api.dart';
import 'package:al_fursan/gallery/videos_gallery/vedio.dart';
import 'package:al_fursan/gallery/videos_gallery/video_display_screen.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/utilities/models_data.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class VideosScreen extends StatefulWidget {
  bool language;

  VideosScreen(this.language);

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  GalleryVideosApi galleryVideosApi = GalleryVideosApi();
  SimilarWidgets similarWidgets = SimilarWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage("assets/images/bg-home.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder(
        future: galleryVideosApi.getVideos(),
        builder: (context, AsyncSnapshot snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              return similarWidgets.noConnection(
                context,
                0.85,
                .35,
              );
              break;
            case ConnectionState.waiting:
              return similarWidgets.loading(
                context,
                0.85,
                .35,
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapShot.hasError) {
                return error(
                  context,
                  snapShot.error.toString(),
                  0.85,
                  .35,
                );
              } else {
                if (snapShot.hasData) {
                  List<Video> allVideos = snapShot.data;
                  return _drawVideos(allVideos);
                } else if (!snapShot.hasData) {
                  return similarWidgets.noData(context, "NO DATA", 0.85, .35);
                }
              }
              break;
          }
          return Container();
        },
      ),
    );
  }

  Widget _drawVideos(List<Video> videos) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(9),
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: widget.language
                        ? ((videos[pos].linkAR == null)
                            ? Image.asset(
                                "assets/images/qm.png",
                              )
                            : Center(
                                child: Container(
                                  child: RaisedButton(
                                    padding: EdgeInsets.all(8),
                                    color: AppColors.darkBG,
                                    child: Text(
                                      videos[pos].titleAR == ''
                                          ? "فيديو"
                                          : videos[pos].titleEN,
                                      style: TextStyle(
                                        fontFamily: 'elmessiri',
                                        letterSpacing: 1.1,
                                        fontSize: 22,
                                        color: AppColors.witheBG,
                                      ),
                                    ),
                                    onPressed: () =>
                                        FlutterYoutube.playYoutubeVideoByUrl(
                                      apiKey: "<API_KEY>",
                                      videoUrl: videos[pos].linkAR,
                                      autoPlay: true, //default falase
                                      fullScreen: false,
                                      //default false
                                    ),
                                  ),
                                ),
                              ))
                        : ((videos[pos].linkEN == null)
                            ? Image.asset(
                                "assets/images/qm.png",
                              )
                            : Center(
                                child: RaisedButton(
                                  padding: EdgeInsets.all(8),
                                  color: AppColors.darkBG,
                                  child: Text(
                                    videos[pos].titleEN == ''
                                        ? "Not has title"
                                        : videos[pos].titleEN,
                                    style: TextStyle(
                                      fontFamily: 'elmessiri',
                                      fontSize: 22,
                                      letterSpacing: 1.1,
                                      color: AppColors.witheBG,
                                    ),
                                  ),
                                  onPressed: () =>
                                      FlutterYoutube.playYoutubeVideoByUrl(
                                    apiKey: "<API_KEY>",
                                    videoUrl: videos[pos].linkEN,
                                    autoPlay: true, //default falase
                                    fullScreen: false,
                                    //default false
                                  ),
                                ),
                              )))),
          ),
        );
      },
      itemCount: videos.length,
    );
  }

  Widget error(
      BuildContext context, String error, double width, double height) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height*0.06,
                left: MediaQuery.of(context).size.width*0.06,
                right: MediaQuery.of(context).size.width*0.06,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                    image: ExactAssetImage("assets/images/qm.png"),
                    fit: BoxFit.fill),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  setState(() {});
                },
                color: Colors.red,
                child: Text(
                  widget.language ? '!...اعد الاتصال ' : 'Reload...!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'elmessiri',
                    color: AppColors.witheBG,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
