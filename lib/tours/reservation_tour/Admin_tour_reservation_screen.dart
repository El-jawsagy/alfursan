import 'package:al_fursan/utilities/models_data.dart';
import 'package:flutter/material.dart';

class AdminTourReservationScreen extends StatefulWidget {
  bool language;
  String tourNameAr;
  String tourNameEn;

  AdminTourReservationScreen(this.language, this.tourNameAr, this.tourNameEn);

  @override
  _AdminTourReservationScreenState createState() =>
      _AdminTourReservationScreenState();
}

class _AdminTourReservationScreenState extends State<AdminTourReservationScreen> {
  var _userReservationUs = new GlobalKey<ScaffoldState>();
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController messageController;
  final userReservationUsKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _userReservationUs,
      appBar: _drawAppBar(widget.language ? "اتصل بنا" : "Contact Us"),
      body: Builder(
        builder: (context) => ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            _drawFormMassageUs(),
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
              textController: firstNameController,
              lines: 1,
              title: widget.language ? "الاسم الاول" : "First Name",
              massageError: widget.language
                  ? "من فضلك ادخل الاسم الاول الخاص بك"
                  : "Please Enter Your First Name",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _drawEditText(
              textController: lastNameController,
              lines: 1,
              title: widget.language ? "الاسم الاخير" : "Last Name",
              massageError: widget.language
                  ? "من فضلك ادخل الاسم الاخير الخاص بك"
                  : "Please Enter Your Last Name",
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
//                 await contactUsApi
//                    .sendData(nameController.text, phoneController.text,
//                        emailController.text, messageController.text)
//                    .then((val) async {
//                  if (val == "true") {
//                    setState(() {
//                      _showToast(context, 'Your message has sent');
//                      nameController.clear();
//                      emailController.clear();
//                      phoneController.clear();
//                      messageController.clear();
//                    });
//                  } else {
//                    _showToast(
//                        context, "Your message has not sent. Try again please");
//                  }
//                  return null;
//                });
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
                firstNameController.clear();
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
    firstNameController.dispose();

    emailController.dispose();

    phoneController.dispose();

    messageController.dispose();
    super.dispose();
  }
}
