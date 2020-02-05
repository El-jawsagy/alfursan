import 'package:al_fursan/utilities/models_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../SimilarWidgets.dart';
import 'drawer.dart';

class AboutUsScreen extends StatefulWidget {
  bool language;

  AboutUsScreen(this.language);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  ValueNotifier<int> posOfAboutUs = ValueNotifier(1);
  int pos;
  SimilarWidgets similarWidgets;

  List<Map<String, String>> listOfString;

  @override
  void initState() {
    pos = 1;
    similarWidgets = SimilarWidgets();
    listOfString = widget.language ? aboutUsAr : aboutUsEn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawAppBar(widget.language ? "معلومات عنا" : "About Us"),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/bg-home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Stack(children: <Widget>[
                _drawCardsOfAbout(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: similarWidgets.drawDots(
                      pos: posOfAboutUs,
                      length: listOfString.length,
                    )),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawCardsOfAbout() {
    return CarouselSlider(
      autoPlayInterval: Duration(seconds: 20),
      autoPlay: true,
      initialPage: pos,
      viewportFraction: 0.9,
      height: MediaQuery.of(context).size.height * .8,
      items: listOfString.map((i) {
        return Builder(
          builder: (BuildContext context) {
            Map<String, String> page = i;
            return Stack(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.87,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  width: MediaQuery.of(context).size.width * 0.87,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      color: AppColors.darkWithOpen2BG,
                      borderRadius: BorderRadius.circular(9)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Text(
                          page['Title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.witheBG,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          page['description'],
                          style: TextStyle(
                              color: AppColors.witheBG,
                              fontFamily: 'elmessiri',
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
      onPageChanged: (val) {
        setState(() {
          pos = val;
        });
      },
    );
  }
}
