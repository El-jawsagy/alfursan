import 'package:al_fursan/main.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../preferences.dart';

class DrawerScreen extends StatefulWidget {
  bool language;

  DrawerScreen(this.language);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkWithOpen1BG,
              AppColors.darkBG,
              AppColors.darkWithOpen1BG,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  _drawRowUser(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  _drawColumnOfButtonsForNav(),
                ],
              ),
              _drawButtonToChangeLanguage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawRowUser() {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
          maxHeight: MediaQuery.of(context).size.height * 0.4),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.16,
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(
                  "assets/images/logo.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            widget.language ? "الفرسان ترافيل" : " Alfursan Travel ",
            style: TextStyle(
              color: AppColors.witheBG,
              fontSize: 18,
              fontFamily: "elmessiri",
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _drawColumnOfButtonsForNav() {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.85),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.85,
      child: ListView.builder(
        itemBuilder: (context, pos) {
          List<Page> pages = allAppPages(widget.language);
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, pages[pos].pageRout);
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListTile(
                title: Text(
                  pages[pos].pageName,
                  style: TextStyle(color: AppColors.witheBG, fontSize: 18),
                ),
                leading: Icon(
                  pages[pos].icon,
                  color: AppColors.witheBG,
                ),
                trailing: Icon(
                  FontAwesomeIcons.arrowCircleRight,
                  color: AppColors.witheBG,
                ),
              ),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }

  Widget _drawButtonToChangeLanguage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () async {
            widget.language
                ? await Preferences.setLanguage(false)
                : await Preferences.setLanguage(true);
            setState(() {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Fursan()));
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    widget.language ? 'English' : 'العربية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: "elmessiri",
                      color: AppColors.witheBG,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .1,
                    height: MediaQuery.of(context).size.height * .03,
                    child: Image.asset(
                      widget.language
                          ? "assets/images/uk.png"
                          : "assets/images/eg.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
