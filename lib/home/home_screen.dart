import 'package:al_fursan/tours/tours_screens/single_tour_screen.dart';
import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/home/trending_tours_api.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  bool language;

  HomeScreen(this.language);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<int> posOfTours = ValueNotifier(0);
  TrendingToursApi toursApi = TrendingToursApi();
  SimilarWidgets similarWidgets;

  @override
  initState() {
    similarWidgets = SimilarWidgets();
    super.initState();
  }

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
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            _drawTextTrending(),
            FutureBuilder(
              future: toursApi.fetchTours(),
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
                        List<Tour> tours = snapShot.data;
                        if (tours != null) {
                          return _drawTrendingTours(tours);
                        } else {
                          return similarWidgets.noData(
                              context,
                              widget.language
                                  ? "لا توجد عروض حاليا"
                                  : "We don't Have any offer for now",
                              0.85,
                              .35);
                        }
                      } else if (!snapShot.hasData) {
                        return similarWidgets.noData(
                            context, "NO DATA", 0.85, .35);
                      }
                    }
                    break;
                }
                return Container();
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.07,
                maxWidth: MediaQuery.of(context).size.width * .8,
              ),
              child: _drawNavigationButton(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.08,
                maxWidth: MediaQuery.of(context).size.width * .8,
              ),
              child: _drawSocialMedial(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawTextTrending() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.language ? "اخر العروض" : "Last offers",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBG,
              fontFamily: "elmessiri",
            ),
          )
        ],
      ),
    );
  }

  Widget _drawTrendingTours(List<Tour> list) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: <Widget>[
          _drawSliderTours(list),
          Align(
              alignment: Alignment.bottomCenter,
              child: similarWidgets.drawDots(
                pos: posOfTours,
                length: list.length,
              )),
        ],
      ),
    );
  }

  Widget _drawSliderTours(List<Tour> ourTours) {
    return CarouselSlider(
      initialPage: 1,
      autoPlay: true,
      viewportFraction: 0.9,
      autoPlayInterval: Duration(
        seconds: 10,
      ),
      height: MediaQuery.of(context).size.height * .7,
      items: ourTours.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingleTourScreen(
                      i,
                      widget.language,
                    ),
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      height: MediaQuery.of(context).size.height * 0.26,
                      child: (i.imageName == null)
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
                                i.imageName,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkBG,
                            AppColors.darkBG,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(9),
                          bottomLeft: Radius.circular(9),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * .7,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView(
                            children: <Widget>[
                              Text(
                                (widget.language) ? i.nameAr : i.nameEn,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'elmessiri',
                                  color: AppColors.witheBG,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    (widget.language) ? i.offerAR : i.offerEn,
                                    style: TextStyle(
                                      fontSize: 16,
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
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
      onPageChanged: (val) {
        posOfTours.value = val;
      },
    );
  }

  Widget _drawNavigationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _drawButtonVisa(),
        _drawButtonTours(),
      ],
    );
  }

  Widget _drawButtonTours() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/tours'),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.globeEurope,
                size: 30,
                color: AppColors.darkBG,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .03,
              ),
              Text(
                widget.language ? "الرحلات" : "Tours",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'elmessiri',
                  color: AppColors.darkBG,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawButtonVisa() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/visa'),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.book,
                size: 30,
                color: AppColors.darkBG,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .03,
              ),
              Text(
                widget.language ? "تاشيرات" : "Visa",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'elmessiri',
                  color: AppColors.darkBG,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawSocialMedial() {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _drawSocialImage("whatsapp", "assets/images/watsapp.png"),
          _drawSocialImage("facebook", "assets/images/facebook.png"),
          _drawSocialImage("skype", "assets/images/skype.png"),
          _drawSocialImage("insta", "assets/images/insta.png"),
          _drawSocialImage("viber", "assets/images/youtube.png"),
        ],
      ),
    );
  }

  Widget _drawSocialImage(
    String name,
    String image,
  ) {
    return InkWell(
      onTap: () {
        switch (name) {
          case "whatsapp":
            _launchWhatsURL(
              "+9647702756666",
            );
            break;
          case "facebook":
            _launchFaceURL('alfursantravel');
            break;
          case "skype":
            _launchSkypeURL();
            break;
          case "insta":
            _launchInstagramURL("alfursan_travel_tourism");
            break;
          case "viber":
            _launchViperURL("9647702756666");
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width * .13,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          image:
              DecorationImage(image: ExactAssetImage(image), fit: BoxFit.fill),
        ),
      ),
    );
  }

  _launchWhatsURL(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=$phone";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : showDialogWidget("there is no whatsapp installed", context);
  }

  _launchFaceURL(String profile) async {
    var faceBookUrl = "http://facebook.com/$profile";
    await canLaunch(faceBookUrl)
        ? launch(faceBookUrl, forceSafariVC: false)
        : showDialogWidget("we found error", context);
  }

  _launchInstagramURL(String profile) async {
    var instagramUrl = "https://www.instagram.com/$profile";
    await canLaunch(instagramUrl)
        ? launch(instagramUrl, forceSafariVC: false)
        : showDialogWidget("we found error ", context);
  }

  _launchSkypeURL() async {
    var instagramUrl = "https://join.skype.com/invite/cffyill8yTns ";
    await canLaunch(instagramUrl)
        ? launch(instagramUrl, forceSafariVC: false)
        : showDialogWidget("we found error", context);
  }

  _launchViperURL(String phone) async {
    var viperUrl = "viber://add?number=$phone";
    await canLaunch(viperUrl)
        ? launch(viperUrl)
        : showDialogWidget("There is no Viper installed", context);
  }
}
