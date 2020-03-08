import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart' as prefix0;
import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'notification.dart';
import 'notification_api.dart';
import 'notification_card_screen.dart';

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
                  return error(
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
              print(notification.type);
              notification.type != ("notification")
                  ? Navigator.pushNamed(
                      context,
                      notification.type == ("tours")
                          ? "/tours"
                          : (notification.type == ('offer')
                              ? "/offer"
                              : "/visa"))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotificationCard(widget.language, notification)));
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
      width: MediaQuery.of(context).size.width,
      color: prefix0.AppColors.witheBG,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(notification.type == ("tours")
              ? FontAwesomeIcons.plane
              : (notification.type == ('offer')
                  ? Icons.local_offer
                  : (notification.type == ("visa")
                      ? FontAwesomeIcons.ccVisa
                      : Icons.message))),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.79,
                maxHeight: MediaQuery.of(context).size.height * .12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text(
                    notification.titleAR,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'elmessiri',
                      color: AppColors.darkBG,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  notification.time,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'elmessiri',
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRowEn(Notifications notification) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * .12,
      width: MediaQuery.of(context).size.width,
      color: prefix0.AppColors.witheBG,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.79,
                maxHeight: MediaQuery.of(context).size.height * .12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text(
                    notification.titleEn.length >= 30
                        ? (notification.titleEn.substring(0, 30) + " ... ")
                        : notification.titleEn,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'elmessiri',
                      color: AppColors.darkBG,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  notification.time,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'elmessiri',
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Icon(notification.type == ("tours")
              ? FontAwesomeIcons.plane
              : (notification.type == ('offer')
                  ? Icons.local_offer
                  : (notification.type == ("visa")
                      ? FontAwesomeIcons.ccVisa
                      : FontAwesomeIcons.bell))),
        ],
      ),
    );
  }

  Widget error(
      BuildContext context, String error, double width, double height) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.06,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                    image: ExactAssetImage("assets/images/qm.png"),
                    fit: BoxFit.fill),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  setState(() {});
                },
                color: Colors.red,
                child: Text(
                  widget.language ? '!...اعد الاتصال ' : 'Reload...!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'elmessiri',
                    color: AppColors.witheBG,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
