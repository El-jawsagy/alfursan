import 'dart:math';

import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'notification.dart';

class NotificationCard extends StatefulWidget {
  bool language;
  Notifications notification;

  NotificationCard(this.language, this.notification);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  static List<Color> colors = [
    Colors.grey.shade700,
    Colors.tealAccent,
    Colors.blueAccent,
    Colors.teal,
    Colors.deepOrangeAccent,
  ];

  int random = Random().nextInt(colors.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.language ? "اشعار" : "Notification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Card(
            elevation: 15,
            color: AppColors.darkBG,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.language
                        ? widget.notification.titleAR
                        : widget.notification.titleEn,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'elmessiri',
                      color: AppColors.witheBG,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                  child: Text(
                    widget.language
                        ? widget.notification.messageAr
                        : widget.notification.messageEn,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.witheBG,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
