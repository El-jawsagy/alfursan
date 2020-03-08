import 'package:al_fursan/gallery/images_gallery/gallery_image_api.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';

class ImagesScreen extends StatefulWidget {
  bool language;

  ImagesScreen(this.language);

  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  GalleryImageApi galleryImageApi = GalleryImageApi();
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
        future: galleryImageApi.sendData(),
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
                  List<String> allImages = snapShot.data;
                  return _drawImages(allImages);
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

  Widget _drawImages(List<String> images) {
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
                child: (images[pos] == null)
                    ? Image.asset(
                        "assets/images/new-logo.png",
                      )
                    : Image(
                        loadingBuilder:
                            (context, image, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return image;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        image: NetworkImage(
                          images[pos],
                        ),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        );
      },
      itemCount: images.length,
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
