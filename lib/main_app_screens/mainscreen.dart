import 'package:al_fursan/tours/all_tours_screen.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/utilities_screen/drawer.dart';

import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/visa/visa_screen.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final bool language;
  int index;

  MainScreen(this.language,this.index);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex;
  PageController mainPageController;

  @override
  initState() {
    _currentIndex = widget.index;
    mainPageController = PageController(
        initialPage: _currentIndex, keepPage: true, viewportFraction: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // @pop is function to make us navigation from screen to home android screen system
        return pop();
      },
      child: Scaffold(
        appBar:
            _drawAppBar(widget.language ? "شركة الفرسان" : "AlFursan Tarvel"),
        drawer: DrawerScreen(widget.language),
        body: _drawPageScrollable(),
        bottomNavigationBar: _drawNavigationBottomBar(),
      ),
    );
  }

  Widget _drawAppBar(String title) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover),
            ),
            width: 35,
            height: 35,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'elmessiri',
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _drawPageScrollable() {
    return Container(
      child: PageView(
        controller: mainPageController,
        children: <Widget>[
          HomeScreen(widget.language),
          AllToursScreen(widget.language),
          AllVisaScreen(widget.language),
        ],
        onPageChanged: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
      ),
    );
  }

  Widget _drawNavigationBottomBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.darkBG,
      currentIndex: _currentIndex, // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: new Icon(
            Icons.home,
            color: AppColors.witheBG,
          ),
          title: new Text(
            widget.language ? "الرئيسية" : 'Home',
            style: TextStyle(
              color: AppColors.witheBG,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.plane,
            color: AppColors.witheBG,
          ),
          title: Text(
            widget.language ? "رحلات" : 'Tours',
            style: TextStyle(
              color: AppColors.witheBG,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: new Icon(
            FontAwesomeIcons.ccVisa,
            color: AppColors.witheBG,
          ),
          title: new Text(
            widget.language ? "تاشيرات دخول" : 'Visa',
            style: TextStyle(
              color: AppColors.witheBG,
            ),
          ),
        ),
      ],
      onTap: (val) {
        setState(() {
          _currentIndex = val;

          mainPageController.jumpToPage(val);
        });
      },
    );
  }

  @override
  void dispose() {
    mainPageController.dispose();
    super.dispose();
  }
}
