import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';

class GalleryImageApi {
  Future<List<String>> sendData() async {
    await checkInternetConnection();
    String URL = ApiPaths.getImage;
    http.Response response = await http.get(URL);

    List<String> images = [];
    switch (response.statusCode) {
      case 200:
        var res = jsonDecode(response.body);
        var data = res['data'];
        for (var i in data) {
          String image = i['image_name'];
          images.add(image);
        }

        return images;
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
    }
    return null;
  }
}
