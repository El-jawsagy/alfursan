import 'package:shared_preferences/shared_preferences.dart';


class Preferences {
  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString('token');
    return isLogin;
  }

  static Future<void> setLanguage(bool language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('language', language);
  }

  static Future<bool> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isArabic = prefs.getBool('language');
    return isArabic;
  }

  static Future<void> setRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  static Future<String> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role');

    return role;
  }
}


