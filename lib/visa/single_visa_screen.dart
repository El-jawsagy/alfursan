import 'package:al_fursan/tours/reservation_tour/user_tour_reservation_screen.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/utilities/preferences.dart';
import 'package:al_fursan/visa/visa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/models_data.dart';

class SingleVisaScreen extends StatefulWidget {
  bool language;
  Visa singleVisa;

  SingleVisaScreen(this.singleVisa, this.language);

  @override
  _SingleVisaScreenState createState() => _SingleVisaScreenState();
}

class _SingleVisaScreenState extends State<SingleVisaScreen> {
  double opacityOfInfo;
  double opacityOfProgram;
  double opacityOfPrice;

  @override
  void initState() {
    opacityOfInfo = 0;
    opacityOfProgram = 0;
    opacityOfPrice = 0;
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                      widget.language
                          ? "اضغط على زر لتحصل على التفاصيل"
                          : 'Press a button to get the details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'elmessiri',
                        color: AppColors.darkShadow,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _drawButton(
                      widget.language ? "المعلومات" : "Information",
                      opacityOfInfo,
                    ),
                    _drawButton(
                      widget.language ? "المتطلبات" : "requirements",
                      opacityOfProgram,
                    ),
                  ],
                ),
              ),
              _drawAnimatedContainerOfInfo(),
              _drawAnimatedContainerOfProgram(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _drawButton(
                      widget.language ? "السعر" : "Price",
                      opacityOfProgram,
                    ),
                    _drawReserveButton(
                      widget.language ? "احجز الان" : "reserve",
                    )
                  ],
                ),
              ),
              _drawAnimatedContainerOfPrice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawButton(String title, double opacity) {
    return InkWell(
      onTap: () {
        switch (title) {
          case "المعلومات":
          case "Information":
            if (opacityOfInfo == 0) {
              setState(() {
                opacityOfInfo = 1;
                opacityOfProgram = 0;
              });
            } else if (opacityOfInfo == 1) {
              setState(() {
                opacityOfInfo = 0;
              });
            }
            break;
          case "المتطلبات":
          case "requirements":
            if (opacityOfProgram == 0) {
              setState(() {
                opacityOfProgram = 1;
                opacityOfInfo = 0;
              });
            } else if (opacityOfProgram == 1) {
              setState(() {
                opacityOfProgram = 0;
              });
            }
            break;
          case "السعر":
          case "Price":
            if (opacityOfPrice == 0) {
              setState(() {
                opacityOfPrice = 1;
              });
            } else if (opacityOfPrice == 1) {
              setState(() {
                opacityOfPrice = 0;
              });
            }
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.darkBG, borderRadius: BorderRadius.circular(7)),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.08,
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

  Widget _drawAnimatedContainerOfInfo() {
    return (opacityOfInfo <= 0)
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.2,
            child: AnimatedOpacity(
              opacity: opacityOfInfo,
              duration: Duration(seconds: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: <Widget>[
                    Text(
                      widget.language
                          ? widget.singleVisa.descriptionAr
                          : widget.singleVisa.descriptionEn,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _drawAnimatedContainerOfProgram() {
    return (opacityOfProgram <= 0)
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.35,
            child: AnimatedOpacity(
              opacity: opacityOfProgram,
              duration: Duration(seconds: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: <Widget>[
                    Text(
                      widget.language
                          ? widget.singleVisa.requirementsAr
                          : widget.singleVisa.requirementsEn,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _drawAnimatedContainerOfPrice() {
    return (opacityOfPrice <= 0)
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.3,
            child: AnimatedOpacity(
              opacity: opacityOfPrice,
              duration: Duration(seconds: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: widget.language
                    ? _drawPriceInArabic()
                    : _drawPriceInEnglish(),
              ),
            ),
          );
  }

  Widget _drawPriceInArabic() {
    return ListView(
      padding: EdgeInsets.all(24),
      children: <Widget>[
        Row(
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
      ],
    );
  }

  Widget _drawPriceInEnglish() {
    return ListView(
      padding: EdgeInsets.all(24),
      children: <Widget>[
        Row(
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
      ],
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
              builder: (context) => UserTourReservationScreen(widget.language,
                  widget.singleVisa.nameEn, widget.singleVisa.nameAr)));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserTourReservationScreen(widget.language,
                  widget.singleVisa.nameEn, widget.singleVisa.nameAr)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.darkBG, borderRadius: BorderRadius.circular(7)),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.08,
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
