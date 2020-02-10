import 'dart:convert';
import 'package:al_fursan/tours/tour.dart';
import 'package:al_fursan/utilities/utilities_apis/api_paths.dart';
import 'package:al_fursan/utilities/utilities_apis/exception_for_app.dart';
import 'package:http/http.dart' as http;

import 'offer.dart';

class OfferApi {
  //todo: is finished
  Future<List<Offer>> fetchTours() async {
    await checkInternetConnection();
    String URL = ApiPaths.trendingProducts;
    http.Response response = await http.get(
        URL + "hVF4CVDlbuUg18MmRZBA4pDkzuXZi9Rzm5wYvSPtxvF8qa8CK9GiJqMXdAMv");
    List<Offer> offers = [];

    switch (response.statusCode) {
      case 200:

        var data = jsonDecode(response.body);
        print(data);
        for (var item in data['data']) {
          offers.add(Offer.fromJson(item));
        }
        return offers;
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
