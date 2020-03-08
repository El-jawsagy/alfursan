import 'package:al_fursan/offer/single_offer_screen.dart';
import 'package:al_fursan/tours/tours_screens/single_tour_screen.dart';
import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';

import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';

import 'offer.dart';
import 'offer_api.dart';

class AllOfferScreen extends StatefulWidget {
  final bool language;

  AllOfferScreen(
      this.language,
      );

  @override
  _AllOfferScreenState createState() => _AllOfferScreenState();
}

class _AllOfferScreenState extends State<AllOfferScreen> {
  OfferApi allOffer = OfferApi();
  SimilarWidgets similarWidgets = SimilarWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawAppBar(
        widget.language ? "العروض" : "Offers",
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
          future: allOffer.fetchTours(),
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
                  return error(
                    context,
                    snapShot.error.toString(),
                    0.85,
                    .35,
                  );
                } else {
                  if (snapShot.hasData) {
                    List<Offer> allOffer = snapShot.data;
                    return _drawTour(allOffer);
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


  Widget _drawTour(List<Offer> ourOffer) {
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
                    builder: (context) => SingleOfferScreen(
                      ourOffer[pos],
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
                                  ? ourOffer[pos].nameAr
                                  : ourOffer[pos].nameEn,
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
                        child: (ourOffer[pos].imageName == null)
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
                            ourOffer[pos].imageName,
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
      itemCount: ourOffer.length,
    );
  }
  Widget error(
      BuildContext context, String error, double width, double height) {
    return Container(
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
    );
  }
}
