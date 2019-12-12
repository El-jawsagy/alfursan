import 'package:flutter/material.dart';

enum screenType {
  Small,
  Medium,
  Large,
}

class DetectedScreen {
  BuildContext context;
  double height;
  double width;
  screenType sizeName;

  DetectedScreen(this.context) {
    height = MediaQuery.of(this.context).size.height;
    width = MediaQuery.of(this.context).size.width;
    _setNameScreen();
  }

  void _setNameScreen() {
    //todo: edit screen width conditions
    if ((this.width >= 320 && this.width < 360) &&
        (this.height >= 568 && this.height < 640)) {
      sizeName = screenType.Small;
    } else if ((this.width >= 360 && this.width < 412) &&
        (this.height >= 640 && this.height < 732)) {
      sizeName = screenType.Medium;
    } else if (this.width >= 412 && this.height >= 732) {
      sizeName = screenType.Large;
    }
  }
}

class LoginScreenProperties {
  DetectedScreen detectedScreen;
  double editTextSize;
  double forgetTextSize;
  double loginTextSize;
  double faceAndGoogleTextSize;
  double signUpText;

  LoginScreenProperties(DetectedScreen ourScreen) {
    this.detectedScreen = ourScreen;
    _initLogin();
  }

  void _initLogin() {
    switch (this.detectedScreen.sizeName) {
      case screenType.Small:
        this.editTextSize = 8;
        this.forgetTextSize =10;
        this.loginTextSize =17;
        this.faceAndGoogleTextSize =16;
        this.signUpText = 14;
        break;
      case screenType.Medium:
        this.editTextSize = 18;
        this.forgetTextSize = 14;
        this.loginTextSize =22;
        this.faceAndGoogleTextSize = 20;
        this.signUpText =18;
        break;
      case screenType.Large:
        this.editTextSize = 20;
        this.forgetTextSize = 16;
        this.loginTextSize = 24;
        this.faceAndGoogleTextSize = 22;
        this.signUpText =20;
        break;
      default:
        this.editTextSize = 16;
        this.forgetTextSize = 14;
        this.faceAndGoogleTextSize = 20;
    }
  }
}

class SignUpScreenProperties {
  DetectedScreen detectedScreen;

//todo:add all properties of SignUpScreen
  SignUpScreenProperties(DetectedScreen ourScreen) {
    this.detectedScreen = ourScreen;
    _initSignUp();
  }

  void _initSignUp() {
    switch (this.detectedScreen.sizeName) {
      case screenType.Small:
        // TODO: Handle this case.
        break;
      case screenType.Medium:
        // TODO: Handle this case.
        break;
      case screenType.Large:
        // TODO: Handle this case.
        break;
    }
  }
}
