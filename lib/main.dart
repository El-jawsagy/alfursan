import 'package:al_fursan/view/main_app_screens/about_us_screen.dart';
import 'package:al_fursan/view/main_app_screens/contact_us_screen.dart';
import 'package:al_fursan/view/login_screen.dart';
import 'package:al_fursan/view/mainscreen.dart';
import 'package:al_fursan/view/utilities/models_data.dart';
import 'package:al_fursan/view/utilities/preferences.dart';
import 'package:al_fursan/view/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

void main() => runApp(SetYouLanguage());

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
          gradient: LinearGradient(
            colors: [
              AppColors.darkWithOpen1BG,
              AppColors.darkWithOpen2BG,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _drawLoginButton("English"),
            giveSpace(.2, context),
            _drawLoginButton("العربية"),
          ],
        ),
      ),
    );
  }

  Widget _drawLoginButton(String language) {
    return InkWell(
      onTap: () async {
        if (language == "العربية") {
          Navigator.pop(context);
          Preferences.setLanguage(true);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Fursan()));
        }
        if (language == "English") {
          Navigator.pop(context);
          Preferences.setLanguage(false);
          Navigator.push(
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
              LinearGradient(colors: [AppColors.witheBG, AppColors.witheBG]),
        ),
        child: Center(
          child: Text(
            language,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: "elmessiri",
              color: AppColors.darkBG,
            ),
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
    return WillPopScope(
      onWillPop: () {
        // @pop is function to make us navigation from screen to home android screen system
        return pop();
      },
      child: FutureBuilder(
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
                    '/home': (context) => MainScreen(snapshots.data),
                    '/aboutUs': (context) => AboutUsScreen(snapshots.data),
                    '/contactUs': (context) => ContactUsScreen(snapshots.data),
                    '/login': (context) => LoginScreen(snapshots.data),
                  },
                  debugShowCheckedModeBanner: false,
                  home: OpeningWidget(snapshots.data),
                  theme: ThemeData(
                    primaryColor: AppColors.darkBG,
                  ),
                ),
              );
            }
            return Container();
          }),
    );
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
    return FutureBuilder(
        future: Preferences.getToken(),
        builder: (context, snapshotsChildren) {
          if (snapshotsChildren.hasData) {
            return MainScreen(widget.language);
          }

          return LoginScreen(widget.language);
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
