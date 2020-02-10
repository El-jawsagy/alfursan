import 'dart:convert';
import 'package:al_fursan/notification/notification.dart';
import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  //todo: is finished
  Future<List<Notifications>> fetchNotification() async {
    await checkInternetConnection();
    String URL = ApiPaths.getNotification;
    http.Response response = await http.get(URL);
    List<Notifications> notifications = [];

    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        for (var item in data['data']) {
          notifications.add(Notifications.fromJson(item));
        }
        return notifications;
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

  Future<String> updateNotification(int id) async {
    await checkInternetConnection();
      String URL = ApiPaths.updateNotification(id);
    http.Response response = await http.get(URL);

    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        String result = data['data'];
        print(result);
        return result;
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
        return 'false';
        break;
    }
  }


  Future<String> getNotificationStatus() async {
    await checkInternetConnection();
    String URL = ApiPaths.getNotificationState;
    http.Response response = await http.get(URL);

    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        String result = data['data'];
        return result;
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
        return 'false';
        break;
    }
  }
}
