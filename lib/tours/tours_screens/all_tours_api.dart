import 'dart:convert';
import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllToursApi {
  //todo: is finished
  Future<List<Tour>> fetchAllTours() async {
    await checkInternetConnection();

    String URL = ApiPaths.getAllTours(
        "hVF4CVDlbuUg18MmRZBA4pDkzuXZi9Rzm5wYvSPtxvF8qa8CK9GiJqMXdAMv");
    http.Response response = await http.get(URL);
    List<Tour> tours = [];

    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);

        for (var item in data['data']) {
          tours.add(Tour.fromJson(item));
        }
        return tours;
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
