import 'dart:convert';
import 'dart:io';
import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:dio/dio.dart';

import 'package:path/path.dart';

class UserTourReservationApi {
  //todo: is finished
  Future<String> sendUserReservation(
      String nameInArabic,
      String nameInEnglish,
      String phoneNumber,
      String emailAddress,
      String address,
      String message,
      String tourNameEn,
      String tourNameAr,
      List<File> images,) async {
    await checkInternetConnection();
    String URL = ApiPaths.userToursReservation;

    FormData formData = new FormData.from(
      {
        'sender_name': nameInArabic,
        'sender_last_name': nameInEnglish,
        'sender_phone_number': phoneNumber,
        'sender_email_address': emailAddress,
        'sender_address': address,
        'notes': message,
        'tour_name_en': tourNameEn,
        'tour_name_ar': tourNameAr,
      },
    );
    for (var i = 0; i < images.length; i++) {
      formData.add(
          "image${i + 1}", UploadFileInfo(images[i], basename(images[i].path)));
    }

    Response response = await Dio().post(URL, data: formData);

    switch (response.statusCode) {
      case 200:
        var data = response.data;
        print(data);
        String state;
        state = data["data"];

        return state;
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      case 404:
        throw ResourcesNotFound();
        break;
      case 500:
        throw NoConnectionWithServer();
        break;
      default:
        return null;
        break;
    }
  }
}
