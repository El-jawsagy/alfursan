import 'dart:convert';
import 'dart:io';
import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

class UserVisaReservationApi {
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
    File image1,
    File image2,
    File image3,
    File image4,
    File image5,
    File image6,
  ) async {
    await checkInternetConnection();
    String URL = ApiPaths.userVisaReservation;
    FormData formData = new FormData.from({
      'sender_name': nameInArabic,
      'sender_last_name': nameInEnglish,
      'sender_phone_number': phoneNumber,
      'sender_email_address': emailAddress,
      'sender_address': address,
      'notes': message,
      'tour_name_en': tourNameEn,
      'tour_name_ar': tourNameAr,
    });
    if (image1 != null) {
      formData.add("image1", UploadFileInfo(image1, basename(image1.path)));
    }
    if (image2 != null) {
      formData.add("image2", UploadFileInfo(image2, basename(image2.path)));
    }
    if (image3 != null) {
      formData.add("image3", UploadFileInfo(image3, basename(image3.path)));
    }
    if (image4 != null) {
      formData.add("image4", UploadFileInfo(image4, basename(image4.path)));
    }
    if (image5 != null) {
      formData.add("image5", UploadFileInfo(image5, basename(image5.path)));
    }

    if (image6 != null) {
      formData.add("image6", UploadFileInfo(image6, basename(image6.path)));
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

// Method for showing snak bar message

}
