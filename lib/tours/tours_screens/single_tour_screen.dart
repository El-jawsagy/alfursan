import 'package:al_fursan/tours/reservation_tour/user_tour_reservation_screen.dart';
import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/utilities/models_data.dart' as prefix0;
import 'package:al_fursan/utilities/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/models_data.dart';

class SingleTourScreen extends StatefulWidget {
  bool language;
  Tour singleTour;

  SingleTourScreen(this.singleTour, this.language);

  @override
  _SingleTourScreenState createState() => _SingleTourScreenState();
}

class _SingleTourScreenState extends State<SingleTourScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.language ? widget.singleTour.nameAr : widget.singleTour.nameEn,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'elmessiri',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/bg-home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: (widget.singleTour.imageName == null)
                          ? ExactAssetImage(
                              "assets/images/new-logo.png",
                            )
                          : NetworkImage(
                              widget.singleTour.imageName,
                            ),
                      fit: BoxFit.cover),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkShadow,
                      AppColors.darkShadow,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(11),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      widget.language ? " التفاصيل" : 'The details',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'elmessiri',
                        color: AppColors.darkBG,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              _drawTitle(
                widget.language ? "المعلومات" : "Information",
              ),
              _drawContainerOfInfo(),
              _drawTitle(
                widget.language ? "البرنامج" : "Program",
              ),
              _drawContainerOfProgram(),
              _drawTitle(
                widget.language ? "يشمل" : "Include",
              ),
              _drawContainerOfInclude(),
              _drawTitle(
                widget.language ? "لا يشمل" : "Exclude",
              ),
              _drawContainerOfExclude(),
              _drawTitle(
                widget.language ? "الاسعار" : "Prices",
              ),
              _drawAnimatedContainerOfPrice(),
              _drawPDFButton(widget.singleTour.file),
              _drawReserveButton(
                widget.language ? "احجز الان" : "reserve",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'elmessiri',
              color: AppColors.darkShadow,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _drawContainerOfInfo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Html(
          data: widget.language
              ? (widget.singleTour.informationAr != "")
                  ? widget.singleTour.informationAr
                  : ("لا يوجد معلومات فى الوقت الحالي")
              : (widget.singleTour.informationEn != "")
                  ? widget.singleTour.informationEn
                  : ("There's no information right now"),
          defaultTextStyle: TextStyle(
              color: AppColors.darkBG,
              fontWeight: FontWeight.bold,
              fontSize: 22),
          customTextAlign: (t) {
            return TextAlign.center;
          },
        ),
      ),
    );
  }

  Widget _drawContainerOfProgram() {
    print(widget.singleTour.programAr);
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Html(
          data: widget.language
              ? (widget.singleTour.programAr != "")
                  ? widget.singleTour.programAr
                  : ("لا يوجد برنامج فى الوقت الحالي")
              : (widget.singleTour.programEn != "")
                  ? widget.singleTour.programEn
                  : ("There's no program right now"),
          defaultTextStyle: TextStyle(
            color: AppColors.darkBG,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          customTextAlign: (t) {
            return TextAlign.center;
          },
        ),
      ),
    );
  }

  Widget _drawContainerOfInclude() {
    print(widget.singleTour.programAr);
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Html(
          data: widget.language
              ? (widget.singleTour.includeAr != "")
                  ? widget.singleTour.includeAr
                  : ("لا يوجد معلومات فى الوقت الحالي")
              : (widget.singleTour.includeEn != "")
                  ? widget.singleTour.includeEn
                  : ("There's no information right now"),
          defaultTextStyle: TextStyle(
            color: AppColors.darkBG,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          customTextAlign: (t) {
            return TextAlign.center;
          },
        ),
      ),
    );
  }

  Widget _drawContainerOfExclude() {
    print(widget.singleTour.programAr);
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Html(
          data: widget.language
              ? (widget.singleTour.excludeAr != "")
                  ? widget.singleTour.excludeAr
                  : ("لا يوجد معلومات فى الوقت الحالي")
              : (widget.singleTour.excludeEn != "")
                  ? widget.singleTour.excludeEn
                  : ("There's no information right now"),
          defaultTextStyle: TextStyle(
            color: AppColors.darkBG,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          customTextAlign: (t) {
            return TextAlign.center;
          },
        ),
      ),
    );
  }

  Widget _drawAnimatedContainerOfPrice() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: widget.language ? _drawPriceInArabic() : _drawPriceInEnglish(),
        ),
      ),
    );
  }

  Widget _drawPriceInArabic() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.singleTour.ticketSinglePrice.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
            Text(
              "فرد واحد",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.singleTour.ticketTreblePrice.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
            Text(
              "مزدوج او ثلاثي",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.singleTour.ticketChd2Price.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
            Text(
              "طفل 2-6",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.singleTour.ticketChd6Price.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
            Text(
              "طفل 6-11",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.singleTour.ticketInfantPrice.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
            Text(
              "طفل رضيع",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawPriceInEnglish() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Single",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              widget.singleTour.ticketSinglePrice.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Double Or Triple",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              widget.singleTour.ticketTreblePrice.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Child 2-6",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              widget.singleTour.ticketChd2Price.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Child 6-11",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              widget.singleTour.ticketChd6Price.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Infant",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              widget.singleTour.ticketInfantPrice.toString() + r"$",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.darkWithOpen1BG),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawPDFButton(String fileName) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: RaisedButton(
              onPressed: () => _downloadFile(fileName),
              color: prefix0.AppColors.darkBG,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    widget.language ? "حمل الرحلة" : 'Download Tour',
                    style: TextStyle(fontSize: 22, color: AppColors.witheBG),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Icon(Icons.description, color: AppColors.witheBG)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _downloadFile(String file) async {
    var pdfUrl = "https://alfursantravel.com/download-file/$file";
    await canLaunch(pdfUrl)
        ? launch(pdfUrl, forceSafariVC: false)
        : showDialogWidget("we can't download", context);
  }

  Widget _drawReserveButton(
    String title,
  ) {
    return InkWell(
      onTap: () async {
        String role = await Preferences.getRole();

        if (role == 'admin') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserTourReservationScreen(widget.language,
                  widget.singleTour.nameEn, widget.singleTour.nameAr)));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserTourReservationScreen(widget.language,
                  widget.singleTour.nameEn, widget.singleTour.nameAr)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.darkBG, borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.witheBG,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
