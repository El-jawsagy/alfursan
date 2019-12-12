import 'dart:convert';

import 'package:al_fursan/api_classes/utilities_apis/api_paths.dart';
import 'package:al_fursan/model/category/category.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryApi {
  Future<List<Category>> fetchCategory() async {
    String URL = ApiPaths.allCategoryApi;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    http.Response response = await http.get(URL + token);
    List<Category> categories = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data['data']) {
        categories.add(Category.fromJson(item));
      }
      return categories;
    }
    return null;
  }
}
