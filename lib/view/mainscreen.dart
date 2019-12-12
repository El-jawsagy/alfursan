import 'package:al_fursan/view/drawer.dart';
import 'package:al_fursan/view/utilities/models_data.dart';
import 'package:al_fursan/view/utilities/widgets.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'main_app_screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  final bool language;

  MainScreen(this.language);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Page> pages;
  int _currentIndex;
  PageController mainPageController;

  @override
  initState() {
    pages = navigationPages();
    _currentIndex = 0;
    mainPageController = PageController(
        initialPage: _currentIndex, keepPage: false, viewportFraction: 1);
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
            _drawAppBar(widget.language ? "الفرسان ترافيل" : "AlFursan Tarvel"),
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
          HomeScreen(widget.language),
          HomeScreen(widget.language),
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
          icon: new Icon(
            FontAwesomeIcons.ticketAlt,
            color: AppColors.witheBG,
          ),
          title: new Text(
            widget.language ? "تذاكر" : 'Ticketes',
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
      ],
      onTap: (val) {
        setState(() {
          _currentIndex = val;
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
