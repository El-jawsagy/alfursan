import 'dart:convert';
import 'package:al_fursan/api_classes/utilities_apis/api_paths.dart';
import 'package:al_fursan/model/tours/tour.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleTourApi {
  Future<Tour> fetchTours(String slug) async {
    String URL = ApiPaths.singleProduct;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    http.Response response = await http.get(URL + slug + "?token=" + token);
    Tour tour;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      tour = Tour.fromJson(data['data']);

      return tour;
    }
    return null;
  }
}
