import 'package:flutter/material.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'models_data.dart';

class SimilarWidgets {
  Widget emailField(TextEditingController emailCon, BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.height / 30,
          0,
          MediaQuery.of(context).size.height / 30,
          MediaQuery.of(context).size.height / 30),
      child: TextFormField(
        controller: emailCon,
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 15.0),
        decoration: InputDecoration(
          labelText: "Email Address",
          hintText: "Email Address",
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),

          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value.isEmpty) {
            return "Email Address shouldn't be empty";
          } else {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(value))
              return "Email Address is wrong";
            else
              return null;
          }
        },
      ),
    );
  }

  void showWaiting(BuildContext contxt) {
    // flutter defined function
    showDialog(
      context: contxt,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: new Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget emptyPage(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Page is Empty",
              style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawDots({ValueNotifier pos, int length}) {
    return ValueListenableBuilder(
      valueListenable: pos,
      builder: (context, value, _) {
        return DotsIndicator(
            dotsCount: length,
            position: value.ceilToDouble(),
            decorator: DotsDecorator(
              color: AppColors.grey,
              activeColor: AppColors.darkBG,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ));
      },
    );
  }

  Widget giveSpace(double about, BuildContext context,
      {bool vertical = false}) {
    if (!vertical) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * about,
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * about,
    );
  }

  Widget loading(BuildContext context, double width, double height) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget noData(
      BuildContext context, String title, double width, double height) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: Center(
        child: Text(title),
      ),
    );
  }

  Widget error(
      BuildContext context, String error, double width, double height) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: Center(
        child: Text(error),
      ),
    );
  }

  Widget noConnection(BuildContext context, double width, double height) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: Center(
        child: Text(
          "No Connection with INTERNET",
        ),
      ),
    );
  }

//

}

Future<void> pop() async {
  await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
}

void showDialogWidget(String str, BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        //title: new Text("Alert Dialog title"),
        content: new Text(str),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
