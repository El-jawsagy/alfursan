import 'package:al_fursan/notification/notification_api.dart';
import 'package:al_fursan/offer/offer_screen.dart';
import 'package:al_fursan/tours/tours_screens/all_tours_screen.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/utilities/preferences.dart';
import 'package:al_fursan/utilities/utilities_screen/about_us_screen.dart';
import 'package:al_fursan/visa/visa_screens/visa_screen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'contact_us/contact_us_screen.dart';
import 'gallery/gallery_screen.dart';
import 'home/mainscreen.dart';
import 'notification/notification_Screen.dart';

void main() {
  runApp(SetYouLanguage());
}

class SetYouLanguage extends StatefulWidget {
  @override
  _SetYouLanguageState createState() => _SetYouLanguageState();
}

class _SetYouLanguageState extends State<SetYouLanguage> {
  var bloc = BlocHome();

  @override
  void initState() {
    bloc.initOneSignal();
    super.initState();
  }

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

class BlocHome {
  void initOneSignal() async {
    await OneSignal.shared.init(
      "3579a84e-0611-47d5-9c64-e6bf8fc91610",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: true,
      },
    );
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }
}

class SetIt extends StatefulWidget {
  @override
  _SetItState createState() => _SetItState();
}

class _SetItState extends State<SetIt> {
  @override
  void initState() {
    Preferences.setLanguage(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Fursan();
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
                  '/home': (context) => MainScreen(snapshots.data),
                  '/tours': (context) => AllToursScreen(snapshots.data),
                  '/aboutUs': (context) => AboutUsScreen(snapshots.data),
                  '/contactUs': (context) => ContactUsScreen(snapshots.data),
                  '/visa': (context) => AllVisaScreen(snapshots.data),
                  '/gallery': (context) => GalleryScreen(snapshots.data),
                  '/notification': (context) =>
                      NotificationsScreen(snapshots.data),
                  '/offer': (context) => AllOfferScreen(snapshots.data),
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
  NotificationApi notificationApi = NotificationApi();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(widget.language);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
