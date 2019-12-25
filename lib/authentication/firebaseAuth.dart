import 'dart:convert';

import 'package:al_fursan/user/user.dart';
import 'package:al_fursan/utilities/SimilarWidgets.dart';
import 'package:al_fursan/utilities/preferences.dart';
import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'authenticable.dart';

class UserAuthentication extends Authenticatable {
  //todo: is finished
  Future<String> login(String email, String password) async {
    try {
      await checkInternetConnection();
    } on NoInterNetConnection catch (e) {
      return "no internet";
    }
    String URL = ApiPaths.login;
    Map<String, String> body = {'email': email, 'password': password};
    http.Response response = await http.post(URL, body: body);
    User user;

    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        print(data);
        if (data['data'] == 'Wrong email') {
          return 'Wrong email';
        } else if (data['data'] == 'Wrong Password') {
          return 'Wrong Password';
        } else {
          user = User.fromJson(data['data']);
          await Preferences.setToken(user.apiToken);
          await Preferences.setRole(user.role);
        }
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
        return "false";
        break;
    }
  }

//  singOut() {
//    .
//    signOut
//    (
//    );
//  }
}
