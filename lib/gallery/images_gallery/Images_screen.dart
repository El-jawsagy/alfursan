import 'package:al_fursan/gallery/images_gallery/gallery_image_api.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:flutter/material.dart';

class ImagesScreen extends StatefulWidget {
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
                return similarWidgets.error(
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
}
