import 'package:shared_preferences/shared_preferences.dart';

class ApiPaths {
  static String token;
  String slug;
  static String mainApi = "https://alfursantravel.com/ar/api";
  static String allCategoryApi = mainApi + "/categories?token=" ;
  static String singleProduct = mainApi + "/products/";
  static String trendingProducts = mainApi + "/trendingtours?token=";
  static String login = mainApi + "/login";





}
