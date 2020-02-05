import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart' as prefix0;
import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'notification.dart';
import 'notification_api.dart';

class NotificationsScreen extends StatefulWidget {
  bool language;

  NotificationsScreen(this.language);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  SimilarWidgets similarWidgets = SimilarWidgets();
  NotificationApi notificationApi;

  @override
  void initState() {
    notificationApi = NotificationApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawAppBar(
        widget.language ? "تنبيهات" : "Notification",
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(
                  "assets/images/bg-home.jpg",
                ),
                fit: BoxFit.cover)),
        child: FutureBuilder(
          future: notificationApi.fetchNotification(),
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
                    List<Notifications> noti = snapShot.data;
                    return _drawNotification(noti);
                  } else if (!snapShot.hasData) {
                    return similarWidgets.noData(context, "NO DATA", 0.85, .35);
                  }
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _drawNotification(List<Notifications> notifi) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: MediaQuery.of(context).size.height * .0008,
            width: MediaQuery.of(context).size.width,
            color: prefix0.AppColors.grey,
          ),
        );
      },
      itemCount: notifi.length,
      itemBuilder: (BuildContext context, int index) {
        Notifications notification = notifi[index];
        return InkWell(
          onTap: () async {
            await notificationApi
                .updateNotification(notification.id)
                .then((val) {
              Navigator.pushNamed(
                  context, notification.type == ("tours") ? "/tours" : "/visa");
            });
          },
          child: widget.language
              ? _drawRowAr(notification)
              : _drawRowEn(notification),
        );
      },
    );
  }

  Widget _drawRowAr(Notifications notification) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      color: notification.seen == "true"
          ? prefix0.AppColors.witheBG
          : prefix0.AppColors.blueToWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            notification.type == ("tours")
                ? FontAwesomeIcons.plane
                : FontAwesomeIcons.ccVisa,
          ),
          Container(
            child: Text(
              notification.titleAR,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'elmessiri',
                color: AppColors.darkBG,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRowEn(Notifications notification) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      color: notification.seen == "true"
          ? prefix0.AppColors.witheBG
          : prefix0.AppColors.blueToWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              notification.titleEn,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'elmessiri',
                color: AppColors.darkBG,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(
            notification.type == ("tours")
                ? FontAwesomeIcons.plane
                : FontAwesomeIcons.ccVisa,
          ),
        ],
      ),
    );
  }
}
