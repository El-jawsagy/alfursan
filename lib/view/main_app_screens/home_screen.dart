import 'package:al_fursan/api_classes/category/category_api.dart';
import 'package:al_fursan/api_classes/tours/tours_api.dart';
import 'package:al_fursan/model/category/category.dart';
import 'package:al_fursan/model/tours/tour.dart';
import 'package:al_fursan/view/tour_screens/single_tour_screen.dart';
import 'package:al_fursan/view/utilities/models_data.dart';
import 'package:al_fursan/view/utilities/models_data.dart' as prefix0;
import 'package:al_fursan/view/utilities/preferences.dart';
import 'package:al_fursan/view/utilities/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  bool language;

  HomeScreen(this.language);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<int> posOfImages = ValueNotifier(1);
  ValueNotifier<int> posOfTours = ValueNotifier(1);
  CategoryApi categoryApi = CategoryApi();
  ToursApi toursApi = ToursApi();

  @override
  initState() {
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
            _drawTextCategory(),
            FutureBuilder(
              future: categoryApi.fetchCategory(),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.none:
                    return Container(
                      child: noConnection(context, .85, .35),
                    );
                    break;
                  case ConnectionState.waiting:
                    return loading(context, 0.85, .35);
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapShot.hasError) {
                      return error(
                        context,
                        snapShot.error,
                        0.85,
                        .35,
                      );
                    } else {
                      if (snapShot.hasData) {
                        List<Category> categories = snapShot.data;
                        return _drawPageWithImage(categories);
                      } else if (!snapShot.hasData) {
                        return noData(context, 0.85, .35);
                      }
                    }
                    break;
                }
                return Container();
              },
            ),
            _drawTextTrending(),
            FutureBuilder(
              future: toursApi.fetchTours(),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.none:
                    return noConnection(
                      context,
                      0.85,
                      .35,
                    );
                    break;
                  case ConnectionState.waiting:
                    return loading(
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
                        snapShot.error,
                        0.85,
                        .35,
                      );
                    } else {
                      if (snapShot.hasData) {
                        List<Tour> tours = snapShot.data;
                        return _drawTrendingTours(tours);
                      } else if (!snapShot.hasData) {
                        return noData(context, 0.85, .35);
                      }
                    }
                    break;
                }
                return Container();
              },
            ),
            giveSpace(0.08, context)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/contactUs'),
        child: Icon(FontAwesomeIcons.envelope),
        backgroundColor: AppColors.darkBG,
      ),
    );
  }

  Widget _drawTextCategory() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.language ? "الاقسام" : "categories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: prefix0.AppColors.darkWithOpen1BG,
              fontFamily: "elmessiri",
            ),
          )
        ],
      ),
    );
  }

  Widget _drawPageWithImage(List<Category> categories) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: <Widget>[
          _drawImages(categories),
        ],
      ),
    );
  }

  Widget _drawImages(List<Category> ourCategory) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(
        ourCategory.length,
        (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.15,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(),
                  child: Image(
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
                      ourCategory[index].image,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Text(
                      (widget.language)
                          ? ourCategory[index].nameAr
                          : ourCategory[index].nameEn,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: ""),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _drawTextTrending() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.language ? "اخر العروض" : "Last Tours",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: prefix0.AppColors.darkWithOpen1BG,
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
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: <Widget>[
          _drawSliderTours(list),
          Align(
              alignment: Alignment.bottomCenter,
              child: drawDots(
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
      viewportFraction: 0.85,
      autoPlayInterval: Duration(
        seconds: 10,
      ),
      height: MediaQuery.of(context).size.height * .4,
      items: ourTours.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingleTourScreen(i),
                  ),
                );
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (i.imageName == null)
                                ? ExactAssetImage(
                                    "assets/images/new-logo.png",
                                  )
                                : NetworkImage(
                                    i.imageName,
                                  ),
                            fit: BoxFit.cover),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.darkShadow,
                            AppColors.darkShadow,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(9)),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        height: MediaQuery.of(context).size.height * .08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              prefix0.AppColors.darkShadow,
                              prefix0.AppColors.darkShadow,
                            ],
                          ),
                          color: prefix0.AppColors.witheBG,
                        ),
                        child: Center(
                          child: Text(
                            (widget.language) ? i.nameAr : i.nameEn,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'elmessiri',
                              color: prefix0.AppColors.witheBG,
                            ),
                            textAlign: TextAlign.center,
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

  @override
  void dispose() {
    super.dispose();
  }
}
