import 'dart:io';

import 'package:al_fursan/utilities/models_data.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:al_fursan/visa/reservation_visa/user_visa_reservation_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File image1;
File image2;
File image3;
File image4;
File image5;
File image6;

class UserVisaReservationScreen extends StatefulWidget {
  bool language;
  String tourNameAr;
  String tourNameEn;
  int id;

  UserVisaReservationScreen(
      this.id, this.language, this.tourNameAr, this.tourNameEn);

  @override
  _UserVisaReservationScreenState createState() =>
      _UserVisaReservationScreenState();
}

class _UserVisaReservationScreenState extends State<UserVisaReservationScreen> {
  var _userVisaReservationUs = new GlobalKey<ScaffoldState>();
  TextEditingController nameInArabicController;
  TextEditingController nameInEnglishController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController messageController;
  final userVisaReservationUsKey = GlobalKey<FormState>();

  UserVisaReservationApi userVisaReservationApi;

  @override
  void initState() {
    nameInArabicController = TextEditingController();
    nameInEnglishController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    messageController = TextEditingController();
    userVisaReservationApi = UserVisaReservationApi();
    super.initState();
  }

//todo : modify el screen w 3adal el screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _userVisaReservationUs,
      appBar:
          _drawAppBar(widget.language ? "ارسل معلومات " : "Send  Information"),
      body: ListView(
        padding: EdgeInsets.only(bottom: 60),
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          _drawFormMassageUs(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            child: Center(
              child: Text(
                widget.language
                    ? "من فضلك ادخل صورة الهوية و صورة جواز السفر و صورة شخصية لكل شخص"
                    : "Please enter the ID, passport photo and personal photograph of each person",
                style: TextStyle(
                  fontFamily: 'elmessiri',
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.72,
            ),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return DrawTakerImageBox(
                    widget.language,
                    index,
                  );
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          _drawButtonToSubmitOrReset(),
        ],
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
      key: userVisaReservationUsKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            _drawEditText(
              widget.language,
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
              widget.language,
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
              widget.language,
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
              widget.language,
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
              widget.language,
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
              widget.language,
              textController: messageController,
              lines: 6,
              title: widget.language ? "ملحوظات" : "Notes",
              massageError: widget.language
                  ? "من فضلك اذا لم يكن لديك اى ملاحظات اكتب لا يوجد"
                  : "Please if you don't have any notes type 'none'.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawEditText(
    bool language, {
    int lines,
    TextEditingController textController,
    String title,
    String massageError,
  }) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
          labelText: title,
          alignLabelWithHint: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      maxLines: lines,
      textAlign: (language == true ? TextAlign.end : TextAlign.start),
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
              if (userVisaReservationUsKey.currentState.validate()) {
                try {
                  await userVisaReservationApi
                      .sendUserReservation(
                    widget.id,
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
                    print(val);
                    if (val == "true") {
                      setState(() {
                        _showToast(
                            context,
                            widget.language
                                ? "تم استلام طلبك و سيتم اللرد عليك من قبل الموظف المسؤل"
                                : 'Your request has been received and will be answered by the responsible officer');
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
                              : "Your Visa Reservation  has not sent. Try again please");
                    }
                  });
                } on NoInterNetConnection catch (E) {
                  _showToast(context, E.toString());
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
                image1 = null;
                image2 = null;
                image3 = null;
                image4 = null;
                image5 = null;
                image6 = null;
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
    _userVisaReservationUs.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: _userVisaReservationUs.currentState.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void dispose() {
    nameInArabicController.dispose();

    emailController.dispose();

    phoneController.dispose();

    messageController.dispose();
    image1 = null;
    image2 = null;
    image3 = null;
    image4 = null;
    image5 = null;
    image6 = null;
    super.dispose();
  }
}

class DrawTakerImageBox extends StatefulWidget {
  File image;
  bool language;
  int index;

  DrawTakerImageBox(this.language, this.index);

  @override
  _DrawTakerImageBoxState createState() => _DrawTakerImageBoxState();
}

class _DrawTakerImageBoxState extends State<DrawTakerImageBox> {
  Future getImage() async {
    var newImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      switch (widget.index) {
        case 0:
          image1 = newImage;
          widget.image = newImage;
          break;
        case 1:
          image2 = newImage;
          widget.image = newImage;
          break;
        case 2:
          image3 = newImage;
          widget.image = newImage;
          break;
        case 3:
          image4 = newImage;
          widget.image = newImage;
          break;
        case 4:
          image5 = newImage;
          widget.image = newImage;
          break;
        case 5:
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
              margin: EdgeInsets.all(4),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .45,
                maxHeight: MediaQuery.of(context).size.height * .09,
              ),
              width: MediaQuery.of(context).size.width * .45,
              height: MediaQuery.of(context).size.height * .09,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.language ? "اضافة الصورة" : "Add a picture",
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
              height: MediaQuery.of(context).size.height * .09,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.file(
                  widget.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
    );
  }
}
