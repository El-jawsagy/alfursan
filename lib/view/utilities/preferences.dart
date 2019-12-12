import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString('token');
    print("is login" + isLogin);
    return isLogin;
  }

  static Future<bool> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isArabic = prefs.getBool('language');
    return isArabic;
  }

  static Future<void> setLanguage(bool language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('language', language);
  }
}
