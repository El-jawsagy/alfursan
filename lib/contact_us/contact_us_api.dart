import 'dart:convert';

import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:http/http.dart' as http;

class ContactUsApi {
  Future<String> sendData(
    String senderName,
    String senderPhoneNumber,
    String senderEmailAddress,
    String message,
  ) async {
    await checkInternetConnection();
    String URL = ApiPaths.getContactUs(
        senderName, senderPhoneNumber, senderEmailAddress, message);
    http.Response response = await http.get(URL);
    String isSending;
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        isSending = data['data'];
        print(isSending);
        return isSending;
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
    }
    return "false";
  }
}
