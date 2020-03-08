import 'package:al_fursan/utilities/preferences.dart';
import 'package:al_fursan/visa/reservation_visa/user_visa_reservation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../utilities/models_data.dart';
import '../visa.dart';

class SingleVisaScreen extends StatefulWidget {
  bool language;
  Visa singleVisa;

  SingleVisaScreen(this.singleVisa, this.language);

  @override
  _SingleVisaScreenState createState() => _SingleVisaScreenState();
}

class _SingleVisaScreenState extends State<SingleVisaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.language ? widget.singleVisa.nameAr : widget.singleVisa.nameEn,
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
                      image: (widget.singleVisa.image == null)
                          ? ExactAssetImage(
                              "assets/images/new-logo.png",
                            )
                          : NetworkImage(
                              widget.singleVisa.image,
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
                      widget.language ? "التفاصيل" : 'The details',
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
                widget.language ? "المتطلبات" : "Requirements",
              ),
              _drawContainerOfProgram(),
              _drawTitle(
                widget.language ? "السعر" : "Price",
              ),
              _drawAnimatedContainerOfPrice(),
              _drawReserveButton(
                widget.language ? "احجز الان" : "Reserve",
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
              ? (widget.singleVisa.descriptionAr != "")
                  ? widget.singleVisa.descriptionAr
                  : ("لا يوجد معلومات فى الوقت الحالي")
              : (widget.singleVisa.descriptionEn != "")
                  ? widget.singleVisa.descriptionEn
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Html(
            data: widget.language
                ? (widget.singleVisa.requirementsAr != "")
                    ? widget.singleVisa.requirementsAr
                    : ("لا يوجد برنامج فى الوقت الحالي")
                : (widget.singleVisa.requirementsEn != "")
                    ? widget.singleVisa.requirementsEn
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
      ),
    );
  }

  Widget _drawAnimatedContainerOfPrice() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: widget.language ? _drawPriceInArabic() : _drawPriceInEnglish(),
        ),
      ),
    );
  }

  Widget _drawPriceInArabic() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.singleVisa.price.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.darkWithOpen1BG),
          ),
        ],
      ),
    );
  }

  Widget _drawPriceInEnglish() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.singleVisa.price.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.darkWithOpen1BG),
          ),
        ],
      ),
    );
  }

  Widget _drawReserveButton(
    String title,
  ) {
    return InkWell(
      onTap: () async {
        String role = await Preferences.getRole();

        if (role == 'admin') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserVisaReservationScreen(
                  widget.singleVisa.id,
                  widget.language,
                  widget.singleVisa.nameEn,
                  widget.singleVisa.nameAr)));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserVisaReservationScreen(
                  widget.singleVisa.id,
                  widget.language,
                  widget.singleVisa.nameEn,
                  widget.singleVisa.nameAr)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkBG,
          borderRadius: BorderRadius.circular(8),
        ),
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
