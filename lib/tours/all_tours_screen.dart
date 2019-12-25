import 'package:al_fursan/tours/all_tours_api.dart';
import 'package:al_fursan/tours/single_tour_screen.dart';
import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';

import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';

class AllToursScreen extends StatefulWidget {
  final bool language;

  AllToursScreen(
    this.language,
  );

  @override
  _AllToursScreenState createState() => _AllToursScreenState();
}

class _AllToursScreenState extends State<AllToursScreen> {
  AllToursApi allToursApi = AllToursApi();
  SimilarWidgets similarWidgets = SimilarWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(
                  "assets/images/bg-home.jpg",
                ),
                fit: BoxFit.cover)),
        child: FutureBuilder(
          future: allToursApi.fetchAllTours(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
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
                    List<Tour> allTour = snapShot.data;
                    return _drawTour(allTour);
                  } else if (!snapShot.hasData) {
                    return similarWidgets.noData(context, 0.85, .35);
                  }
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _drawTour(List<Tour> ourTours) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SingleTourScreen(
                    ourTours[pos],
                    widget.language,
                  ),
                ),
              );
            },
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: (ourTours[pos].imageName == null)
                          ? Image.asset(
                              "assets/images/new-logo.png",
                            )
                          : Image(
                              loadingBuilder: (context, image,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) {
                                  return image;
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              image: NetworkImage(
                                ourTours[pos].imageName,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(9)),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        height: MediaQuery.of(context).size.height * .08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.darkShadow,
                              AppColors.darkShadow,
                            ],
                          ),
                          color: AppColors.witheBG,
                        ),
                        child: Center(
                          child: Text(
                            (widget.language)
                                ? ourTours[pos].nameAr
                                : ourTours[pos].nameEn,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'elmessiri',
                              color: AppColors.witheBG,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: ourTours.length,
    );
  }
}
