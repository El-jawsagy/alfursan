import 'package:al_fursan/home/home_screen.dart';
import 'package:al_fursan/notification/notification_api.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/preferences.dart';
import 'package:al_fursan/utilities/utilities_screen/drawer.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MainScreen extends StatefulWidget {
  bool language;
  String status;

  MainScreen(this.language, {this.status = 'false'});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationApi notificationApi = NotificationApi();
  String status;

  @override
  initState() {
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
        appBar: _drawAppBar(widget.status,
            widget.language ? "الفرسان" : "AlFursan ", widget.language),
        drawer: DrawerScreen(widget.language),
        body: HomeScreen(widget.language),
      ),
    );
  }

  Widget _drawAppBar(String status, String title, bool language) {
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
      actions: <Widget>[
        Center(
          child: IconButton(
              icon: Icon(
                Icons.notifications_active,
                color: status == 'true' ? Colors.red : Colors.white,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, '/notification')),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: InkWell(
            onTap: () async {
              language
                  ? await Preferences.setLanguage(false)
                  : await Preferences.setLanguage(true);
              setState(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Fursan()));
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: MediaQuery.of(context).size.width * .08,
                height: MediaQuery.of(context).size.height * .01,
                child: Image.asset(
                  language ? "assets/images/uk.png" : "assets/images/eg.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
