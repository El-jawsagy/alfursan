import 'dart:convert';

import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'category.dart';

class CategoryApi {
  Future<List<Category>> fetchCategory() async {
    await checkInternetConnection();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String URL = ApiPaths.getAllCategoryApi(token);

    http.Response response = await http.get(URL);

    List<Category> categories = [];
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        for (var item in data['data']) {
          categories.add(Category.fromJson(item));
        }
        return categories;
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
