import 'dart:convert';

import 'package:al_fursan/api_classes/utilities_apis/api_paths.dart';
import 'package:al_fursan/model/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'authenticable.dart';

class UserAuthentication extends Authenticatable {
  //todo: is finished
  Future<User> login(String email, String password) async {
    String URL = ApiPaths.login;
    Map<String, String> body = {'email': email, 'password': password};
    http.Response response = await http.post(URL, body: body);
    User user;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      user = User.fromJson(data['data']);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', user.apiToken);


      return user;
    }
    return null;
  }

//  singOut() {
//    .
//    signOut
//    (
//    );
//  }
}
