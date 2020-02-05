import 'dart:convert';


import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:al_fursan/visa/visa.dart';
import 'package:http/http.dart' as http;

class VisaApi {
  Future<List<Visa>> fetchVisa() async {
    await checkInternetConnection();
    String URL = ApiPaths.getAllVisaApi("hVF4CVDlbuUg18MmRZBA4pDkzuXZi9Rzm5wYvSPtxvF8qa8CK9GiJqMXdAMv");

    http.Response response = await http.get(URL);

    List<Visa> allVisa = [];
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        for (var item in data['data']) {
          allVisa.add(Visa.fromJson(item));
        }
        return allVisa;
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
