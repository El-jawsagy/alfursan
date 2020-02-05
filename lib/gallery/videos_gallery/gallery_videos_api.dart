import 'dart:convert';
import 'package:al_fursan/gallery/videos_gallery/vedio.dart';
import 'package:http/http.dart' as http;

import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';

class GalleryVideosApi {
  Future<List<Video>> getVideos() async {
    await checkInternetConnection();
    String URL = ApiPaths.getVideos;
    http.Response response = await http.get(URL);

    List<Video> videos = [];
    switch (response.statusCode) {
      case 200:
        var res = jsonDecode(response.body);
        var data = res['data'];
        for (var i in data) {
          print(data);
          videos.add(Video.fromJson(i));
        }
        return videos ;
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
