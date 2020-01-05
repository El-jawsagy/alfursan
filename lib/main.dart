import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/preferences.dart';
import 'package:al_fursan/utilities/utilities_screen/about_us_screen.dart';
import 'package:al_fursan/contact_us/contact_us_screen.dart';

import 'package:al_fursan/main_app_screens/mainscreen.dart';
import 'package:al_fursan/utilities/models_data.dart';

import 'package:flutter/material.dart';

import 'authentication/login_screen.dart';

void main() {
  runApp(SetYouLanguage());
}

class SetYouLanguage extends StatefulWidget {
  @override
  _SetYouLanguageState createState() => _SetYouLanguageState();
}

class _SetYouLanguageState extends State<SetYouLanguage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Preferences.getLanguage(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            if (snapShot.hasData) {
              return Fursan();
            }
            return SetIt();
          },
        ));
  }
}

class SetIt extends StatefulWidget {
  @override
  _SetItState createState() => _SetItState();
}

class _SetItState extends State<SetIt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          color: AppColors.witheBG,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _drawLoginButton("English", "assets/images/uk.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            _drawLoginButton("العربية", "assets/images/eg.png"),
          ],
        ),
      ),
    );
  }

  Widget _drawLoginButton(String language, String image) {
    return InkWell(
      onTap: () async {
        if (language == "العربية") {
          Preferences.setLanguage(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Fursan()));
        }

        if (language == "English") {
          Preferences.setLanguage(false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Fursan()));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .7,
        height: MediaQuery.of(context).size.height * .12,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: .75,
              spreadRadius: .75,
              offset: Offset(0.0, 0.0),
            )
          ],
          borderRadius: BorderRadius.circular(50),
          gradient:
              LinearGradient(colors: [AppColors.darkBG, AppColors.darkBG]),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                language,
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
                  image,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Fursan extends StatefulWidget {
  @override
  _FursanState createState() => _FursanState();
}

class _FursanState extends State<Fursan> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Preferences.getLanguage(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: MaterialApp(
                routes: {
                  '/home': (context) => MainScreen(snapshots.data, 0),
                  '/tours': (context) => MainScreen(snapshots.data, 1),
                  '/aboutUs': (context) => AboutUsScreen(snapshots.data),
                  '/contactUs': (context) => ContactUsScreen(snapshots.data),
                  '/login': (context) => LoginScreen(snapshots.data),
                  '/visa': (context) => MainScreen(snapshots.data, 2),
                },
                debugShowCheckedModeBanner: false,
                home: WillPopScope(
                  onWillPop: () {
                    // @pop is function to make us navigation from screen to home android screen system
                    return pop();
                  },
                  child: OpeningWidget(snapshots.data),
                ),
                theme: ThemeData(
                  primaryColor: AppColors.darkBG,
                ),
              ),
            );
          }
          return Container();
        });
  }
}

class OpeningWidget extends StatefulWidget {
  bool language;

  OpeningWidget(this.language);

  @override
  _OpeningWidgetState createState() => _OpeningWidgetState();
}

class _OpeningWidgetState extends State<OpeningWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(widget.language, 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
