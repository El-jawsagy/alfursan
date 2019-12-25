import 'package:al_fursan/contact_us/contact_us_screen.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/models_data.dart' as prefix0;
import 'package:al_fursan/utilities/multi_screen.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'firebaseAuth.dart';

class LoginScreen extends StatefulWidget {
  bool language;

  LoginScreen(this.language);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController;

  TextEditingController _passwordTextController;

  IconData _icon = Icons.visibility_off;

  bool _isVisible = true;

  bool _isHash = true;

  var _loginState = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  UserAuthentication userAuthentication;

  SimilarWidgets similarWidgets = SimilarWidgets();

  @override
  void initState() {
    _passwordTextController = TextEditingController();
    _emailTextController = TextEditingController();
    userAuthentication = UserAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DetectedScreen detectedScreen = DetectedScreen(context);
    LoginScreenProperties loginScreenProperties =
        LoginScreenProperties(detectedScreen);
//WillPopScope make you can control with back button in android
    return Scaffold(
      key: _loginState,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _drawLogo(),
                _drawEditText(
                    Icons.email,
                    widget.language ? 'ألبريد الالكتروني' : 'Email',
                    'Please enter your email',
                    loginScreenProperties.editTextSize),
                similarWidgets.giveSpace(.03, context),
                _drawPasswordEditText(loginScreenProperties.editTextSize),
                similarWidgets.giveSpace(.04, context),
                _drawLoginButton(loginScreenProperties.loginTextSize),
                similarWidgets.giveSpace(0.13, context),
                _drawContactUs(loginScreenProperties.signUpText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawLogo() {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(
                "assets/images/new-logo.png",
              ),
              fit: BoxFit.cover)),
    );
  }

  Widget _drawEditText(IconData icon, String boxName, String validatorText,
      double titleTextSize) {
    return TextFormField(
      style: TextStyle(fontSize: titleTextSize),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        filled: true,
        isDense: true,
        prefixIcon: Icon(icon),
        hintText: boxName,
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }

  Widget _drawPasswordEditText(double textFontSize) {
    return TextFormField(
      style: TextStyle(
        fontSize: textFontSize,
      ),
      obscureText: _isHash,
      controller: _passwordTextController,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            if (_isVisible) {
              setState(() {
                _icon = Icons.visibility;
                _isHash = false;
                _isVisible = false;
                this._emailTextController.text = _emailTextController.text;
                this._passwordTextController.text =
                    _passwordTextController.text;
              });
            } else if (!_isVisible) {
              setState(() {
                _icon = Icons.visibility_off;
                _isHash = true;
                _isVisible = true;
                this._emailTextController.text = _emailTextController.text;
                this._passwordTextController.text =
                    _passwordTextController.text;
              });
            }
          },
          icon: Icon(_icon),
        ),
        hintText: widget.language ? 'الرقم السري' : "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return widget.language
              ? 'من فضلك ادخل ألبريد الالكتروني'
              : "Enter your password please";
        }
        return null;
      },
    );
  }

  Widget _drawLoginButton(double textButtonSize) {
    return InkWell(
      onTap: () async {
        String name, pass;
        name = _emailTextController.text;
        pass = _passwordTextController.text;
        if (_formKey.currentState.validate()) {
          try {
            userAuthentication.login(name, pass).then((val) {
              switch (val) {
                case 'Wrong email':
                  showDialogWidget("make sure your email is true", context);
                  break;
                case 'Wrong Password':
                  showDialogWidget("make sure your password is true", context);
                  break;
                case "no internet":
                  showDialogWidget("check Your internet connection", context);
                  break;
                default:
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                  );
                  break;
              }
            });
          } catch (e) {
            showDialogWidget(e.toString(), context);
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .45,
        height: MediaQuery.of(context).size.height * .075,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: .75,
              spreadRadius: .75,
              offset: Offset(0.0, 0.0),
            )
          ],
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(colors: [
            prefix0.AppColors.darkBG,
            prefix0.AppColors.darkWithOpen1BG,
          ]),
        ),
        child: Center(
          child: Text(
            widget.language ? 'تسجيل الدخول' : "LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: textButtonSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawContactUs(double signUpScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.language ? 'اتصل بنا' : "Don't have an account?",
          style: TextStyle(fontSize: signUpScreen, color: Color(0xff9e9e9e)),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ContactUsScreen(widget.language),
              ),
            );
          },
          child: Text(
            widget.language ? 'انا لا امتلك حساب ؟' : "Contact Us",
            style: TextStyle(
                fontSize: signUpScreen,
                color: prefix0.AppColors.darkBG,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _passwordTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  Future<void> pop() async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }
}
