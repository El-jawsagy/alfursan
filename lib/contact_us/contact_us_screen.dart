import 'package:al_fursan/contact_us/contact_us_api.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  bool language;

  ContactUsScreen(this.language);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String imageCountry;
  String appName;
  double opacityFirst;
  double opacitySecond;
  String isSend;
  Map<String, dynamic> contact;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController messageController;
  final contactUsKey = GlobalKey<FormState>();
  ContactUsApi contactUsApi = ContactUsApi();

  void initState() {
    imageCountry = "assets/images/uk.png";

    appName = "اتصل بنا";
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    messageController = TextEditingController();

    opacityFirst = 0;

    super.initState();
  }

  var _contactUs = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _contactUs,
      appBar: drawAppBar(
        widget.language ? "اتصل بنا" : "Contact Us",
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/bg-home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Builder(
          builder: (context) => ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _drawButton(
                        widget.language ? "الفرع الرئيسي" : "Main Branch"),
                    _drawButton(
                        widget.language ? "الفرع الثاني" : "Second Branch"),
                  ],
                ),
              ),
              (opacityFirst == 1) ? _drawInfoBranch() : _drawEmptyInfo(),
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
      ),
    );
  }

  Widget _drawButton(String title) {
    return InkWell(
      onTap: () {
        if (title == "الفرع الرئيسي" || title == "الفرع الثاني") {
          setState(() {
            opacityFirst = 1;

            if (title == "الفرع الرئيسي") {
              contact = prefix0.contactFirstAr;
            } else if (title == "الفرع الثاني") {
              contact = prefix0.contactSecondAR;
            }
          });
        } else if (title == "Main Branch" || title == "2nd Branch") {
          setState(() {
            opacityFirst = 1;

            if (title == "Main Branch") {
              contact = prefix0.contactFirstEN;
            } else if (title == "2nd Branch") {
              contact = prefix0.contactSecondEN;
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: prefix0.AppColors.darkBG,
            borderRadius: BorderRadius.circular(7)),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: prefix0.AppColors.witheBG,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawInfoBranch() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.3,
      child: AnimatedOpacity(
        opacity: opacityFirst,
        duration: Duration(seconds: 5),
        child: ListView(
          children: <Widget>[
            Text(
              contact['Branch'],
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            ListTile(
              title: Text(
                contact['address'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(
                FontAwesomeIcons.mapMarkedAlt,
                color: prefix0.AppColors.darkBG,
              ),
            ),
            ListTile(
              title: Text(
                contact['number'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(
                FontAwesomeIcons.phone,
                color: prefix0.AppColors.darkBG,
              ),
            ),
            ListTile(
              title: Text(
                contact['email'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(
                FontAwesomeIcons.envelope,
                color: prefix0.AppColors.darkBG,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawEmptyInfo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            widget.language ? "( عناوين فروعنا )" : "( our branch addresses )",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.language
                  ? Text(
                      widget.language
                          ? " من فضلك يرجى اختيار خيار واحد"
                          : "please select one choice",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Icon(
                      FontAwesomeIcons.solidHandPointUp,
                      size: 35,
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              !widget.language
                  ? Text(
                      widget.language
                          ? " من فضلك يرجى اختيار خيار واح "
                          : "please select one choice",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Icon(
                      FontAwesomeIcons.solidHandPointUp,
                      size: 35,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawFormMassageUs() {
    return Form(
      key: contactUsKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            _drawEditText(
              textController: nameController,
              lines: 1,
              title: widget.language ? "الاسم" : "Name",
              massageError: widget.language
                  ? "من فضلك ادخل الاسم الخاص بك"
                  : "Please Enter You name",
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
              textController: messageController,
              lines: 6,
              title: widget.language ? "رسالتك" : "Message",
              massageError: widget.language
                  ? "من فضلك ادخل الرساله الخاصة بك"
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
              if (contactUsKey.currentState.validate()) {
                try {
                  await contactUsApi
                      .sendData(nameController.text, phoneController.text,
                          emailController.text, messageController.text)
                      .then((val) async {
                    if (val == "true") {
                      setState(() {
                        _showToast(context, 'Your message has sent');
                        nameController.clear();
                        emailController.clear();
                        phoneController.clear();
                        messageController.clear();
                      });
                    } else {
                      _showToast(context,
                          "Your message has not sent. Try again please");
                    }
                    return null;
                  });
                } catch (E) {
                  _showToast(context, E.toString());
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: prefix0.AppColors.darkBG,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  widget.language ? "ارسال" : "Send",
                  style: TextStyle(color: prefix0.AppColors.witheBG),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                nameController.clear();
                emailController.clear();
                phoneController.clear();
                messageController.clear();
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: prefix0.AppColors.darkBG,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  widget.language ? "مسح" : "Reset",
                  style: TextStyle(color: prefix0.AppColors.witheBG),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    _contactUs.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: _contactUs.currentState.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();

    phoneController.dispose();

    messageController.dispose();
    super.dispose();
  }
}
