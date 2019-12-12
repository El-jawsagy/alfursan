import 'dart:convert';
import 'package:al_fursan/api_classes/utilities_apis/api_paths.dart';
import 'package:al_fursan/model/tours/tour.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ToursApi {
  //todo: is finished
  Future<List<Tour>> fetchTours() async {
    String URL = ApiPaths.trendingProducts;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    http.Response response = await http.get(URL + token);
    List<Tour> tours = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data['data']) {
        tours.add(Tour.fromJson(item));
      }
      return tours;
    }
    return null;
  }
}
