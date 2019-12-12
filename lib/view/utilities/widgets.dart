import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models_data.dart';

Widget drawDots({ValueNotifier pos, int length}) {
  return ValueListenableBuilder(
    valueListenable: pos,
    builder: (context, value, _) {
      return DotsIndicator(
          dotsCount: length,
          position: value.ceilToDouble(),
          decorator: DotsDecorator(
            color: AppColors.witheBG,
            activeColor: AppColors.darkBG,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ));
    },
  );
}

Widget giveSpace(double about, BuildContext context, {bool vertical = false}) {
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

Widget noData(BuildContext context, double width, double height) {
  return Container(
    width: MediaQuery.of(context).size.width * width,
    height: MediaQuery.of(context).size.height * height,
    child: Center(
      child: Text("NO DATA"),
    ),
  );
}

Widget error(BuildContext context, Error error, double width, double height) {
  return Container(
    width: MediaQuery.of(context).size.width * width,
    height: MediaQuery.of(context).size.height * height,
    child: Center(
      child: Text("we found Error -> $error"),
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
Future<void> pop() async {
  await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
}