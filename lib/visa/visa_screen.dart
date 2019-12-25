import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/visa/all_visa_api.dart';
import 'package:al_fursan/visa/single_visa_screen.dart';

import 'package:al_fursan/visa/visa.dart';

import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';

class AllVisaScreen extends StatefulWidget {
  final bool language;

  AllVisaScreen(
    this.language,
  );

  @override
  _AllVisaScreenState createState() => _AllVisaScreenState();
}

class _AllVisaScreenState extends State<AllVisaScreen> {
  VisaApi allVisaApi = VisaApi();

  SimilarWidgets similarWidgets =SimilarWidgets();
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
          future: allVisaApi.fetchVisa(),
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
                    List<Visa> allVisa = snapShot.data;
                    return _drawVisa(allVisa);
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

  Widget _drawVisa(List<Visa> ourVisa) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SingleVisaScreen(
                    ourVisa[pos],
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
                      child: (ourVisa[pos].image == null)
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
                                ourVisa[pos].image,
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
                                ? ourVisa[pos].nameAr
                                : ourVisa[pos].nameEn,
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
      itemCount: ourVisa.length,
    );
  }
}
