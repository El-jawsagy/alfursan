import 'dart:io';

import 'package:al_fursan/tours/reservation_tour/user_tour_reservation_api.dart';
import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File image1;
File image2;
File image3;
File image4;
File image5;
File image6;

class UserTourReservationScreen extends StatefulWidget {
  bool language;
  String tourNameAr;
  String tourNameEn;

  UserTourReservationScreen(this.language, this.tourNameAr, this.tourNameEn);

  @override
  _UserTourReservationScreenState createState() =>
      _UserTourReservationScreenState();
}

class _UserTourReservationScreenState extends State<UserTourReservationScreen> {
  var _userReservationUs = new GlobalKey<ScaffoldState>();
  TextEditingController nameInArabicController;
  TextEditingController nameInEnglishController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController messageController;
  final userReservationUsKey = GlobalKey<FormState>();

  UserTourReservationApi userTourReservationApi;

  @override
  void initState() {
    nameInArabicController = TextEditingController();
    nameInEnglishController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    messageController = TextEditingController();
    userTourReservationApi = UserTourReservationApi();

    super.initState();
  }

//todo : modify el screen w 3adal el screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _userReservationUs,
      appBar:
          _drawAppBar(widget.language ? "ارسل معلومات " : "Send  Information"),
      body: Builder(
        builder: (context) => ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            _drawFormMassageUs(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DrawTakerImageBox(
                    widget.language ? "صورة جوز السفر" : "Passport Image"),
                DrawTakerImageBox(
                    widget.language ? "صورة الهوية" : "Identity Image"),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DrawTakerImageBox(widget.language
                    ? "صورة شهادة الميلاد"
                    : "birth certificate"),
                DrawTakerImageBox(widget.language
                    ? "الصورة الاضافية الاولي"
                    : "The first additional image"),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DrawTakerImageBox(widget.language
                    ? "الصورة الاضافيةالثانية"
                    : "The second additional picture"),
                DrawTakerImageBox(widget.language
                    ? "الصورة الاضافية الثالثة"
                    : "The third additional picture"),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _drawButtonToSubmitOrReset(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawAppBar(String title) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover),
            ),
            width: 35,
            height: 35,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'elmessiri',
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _drawFormMassageUs() {
    return Form(
      key: userReservationUsKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            _drawEditText(
              textController: nameInArabicController,
              lines: 1,
              title:
                  widget.language ? "الاسم باللغة العربية" : "Name in Arabic",
              massageError: widget.language
                  ? "من فضلك ادخل الاسم باللغة العربية"
                  : "Please Enter Your Name in Arabic",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _drawEditText(
              textController: nameInEnglishController,
              lines: 1,
              title: widget.language
                  ? "الاسم باللغة الانجليزية"
                  : "Name in English",
              massageError: widget.language
                  ? "من فضلك ادخل الاسم باللغة الانجليزية"
                  : "Please Enter Your Name in English",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _drawEditText(
              textController: emailController,
              lines: 1,
              title: widget.language ? "البريد الالكتروني" : "Email",
              massageError: widget.language
                  ? "من فضلك ادخل البريد الالكتروني"
                  : "Please Enter You Email",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _drawEditText(
              textController: phoneController,
              lines: 1,
              title: widget.language ? "رقم الهاتف" : "Phone Number",
              massageError: widget.language
                  ? "من فضلك ادخل رقم الهاتف"
                  : "Please Enter You Phone Number",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _drawEditText(
              textController: addressController,
              lines: 1,
              title: widget.language ? "العنوان" : "Address",
              massageError: widget.language
                  ? "من فضلك ادخل العنوان الخاص بك"
                  : "Please Enter Your Address",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _drawEditText(
              textController: messageController,
              lines: 6,
              title: widget.language ? "ملحوظات" : "Notes",
              massageError: widget.language
                  ? "من فضلك قم بكتابة الاشخاص الذي تريد اصطحابهم معك / او اذا كان لديك اى ملاحظات"
                  : "Please Enter You Message",
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawEditText({
    int lines,
    TextEditingController textController,
    String title,
    String massageError,
  }) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      maxLines: lines,
      validator: (val) {
        if (val.isEmpty) {
          return massageError;
        }
        return null;
      },
    );
  }

  Widget _drawButtonToSubmitOrReset() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * .8,
        maxHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: () async {
              if (userReservationUsKey.currentState.validate()) {
                try {
                  await userTourReservationApi
                      .sendUserReservation(
                    nameInArabicController.text,
                    nameInEnglishController.text,
                    phoneController.text,
                    emailController.text,
                    addressController.text,
                    messageController.text,
                    widget.tourNameEn,
                    widget.tourNameAr,
                    image1,
                    image2,
                    image3,
                    image4,
                    image5,
                    image6,
                  )
                      .then((val) async {
                    if (val == "true") {
                      setState(() {
                        _showToast(
                            context,
                            widget.language
                                ? "تم الحجز بنجاح"
                                : 'Your Tour Reservation has sent');
                        nameInEnglishController.clear();
                        nameInArabicController.clear();
                        addressController.clear();
                        emailController.clear();
                        phoneController.clear();
                        messageController.clear();
                        image1 = null;
                        image2 = null;
                        image3 = null;
                        image4 = null;
                        image5 = null;
                        image6 = null;
                      });
                    } else {
                      _showToast(
                          context,
                          widget.language
                              ? "لم يتم اتمام الحجز برجاء المحاولة مرة اخري"
                              : "Your Tour Reservation  has not sent. Try again please");
                    }
                  });
                } on NoInterNetConnection catch (e) {
                  _showToast(context, e.toString());
                } catch (e) {
                  _showToast(
                      context,
                      widget.language
                          ? "لم يتم اتمام الحجز برجاء المحاولة مرة اخري"
                          : "Your Tour Reservation  has not sent. Try again please");
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: AppColors.darkBG,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  widget.language ? "ارسال" : "Send",
                  style: TextStyle(color: AppColors.witheBG),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                nameInArabicController.clear();
                emailController.clear();
                phoneController.clear();
                messageController.clear();
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: AppColors.darkBG,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  widget.language ? "مسح" : "Reset",
                  style: TextStyle(color: AppColors.witheBG),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    _userReservationUs.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: _userReservationUs.currentState.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void dispose() {
    nameInArabicController.dispose();

    emailController.dispose();

    phoneController.dispose();

    messageController.dispose();
    super.dispose();
  }
}

class DrawTakerImageBox extends StatefulWidget {
  File image;
  String description;

  DrawTakerImageBox(this.description);

  @override
  _DrawTakerImageBoxState createState() => _DrawTakerImageBoxState();
}

class _DrawTakerImageBoxState extends State<DrawTakerImageBox> {
  Future getImage() async {
    var newImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      switch (widget.description) {
        case "صورة جوز السفر":
        case "Passport Image":
          image1 = newImage;
          widget.image = newImage;
          break;
        case "صورة الهوية":
        case "Identity Image":
          image2 = newImage;
          widget.image = newImage;
          break;
        case "صورة شهادة الميلاد":
        case "birth certificate":
          image3 = newImage;
          widget.image = newImage;
          break;
        case "الصورة الاضافية الاولي":
        case "The first additional image":
          image4 = newImage;
          widget.image = newImage;
          break;
        case "الصورة الاضافيةالثانية":
        case "The second additional picture":
          image5 = newImage;
          widget.image = newImage;
          break;
        case "الصورة الاضافية الثالثة":

        case "The third additional picture":
          image5 = newImage;
          widget.image = newImage;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          getImage();
        });
      },
      child: (widget.image == null)
          ? Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .45,
                maxHeight: MediaQuery.of(context).size.height * .15,
              ),
              width: MediaQuery.of(context).size.width * .45,
              height: MediaQuery.of(context).size.height * .15,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width * .45,
              height: MediaQuery.of(context).size.height * .15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.file(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
