import 'package:al_fursan/main.dart';
import 'package:al_fursan/tours/tours_screens/all_tours_api.dart';
import 'package:al_fursan/tours/tours_screens/single_tour_screen.dart';
import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';

import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/utilities/preferences.dart';
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
      appBar: drawAppBar(
        widget.language ? "الرحلات" : "Tours",
      ),
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
                    return similarWidgets.noData(context, "NO DATA", 0.85, .35);
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
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkBG,
              borderRadius: BorderRadius.circular(9),
            ),
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
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(2),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(9),
                              bottomLeft: Radius.circular(9),
                            ),
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
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(9),
                        bottomLeft: Radius.circular(9),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
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
                ],
              ),
            ),
          ),
        );
      },
      itemCount: ourTours.length,
    );
  }
}
