import 'package:shared_preferences/shared_preferences.dart';

class ApiPaths {
  static String mainApi = "https://alfursantravel.com/ar/api";

  static String getAllCategoryApi(String token) {
    return mainApi + "/categories?token=" + token;
  }

  static String getSingleCategoryApi(String token, String slug) {
    return mainApi + "/categories/$slug?token=" + token;
  }

  static String getContactUs(
    String senderName,
    String senderPhoneNumber,
    String senderEmailAddress,
    String message,
  ) {
    return mainApi +
        "/postcontactmsg?sender_name=" +
        senderName +
        "&sender_email_address=" +
        senderEmailAddress +
        "&sender_phone_number=" +
        senderPhoneNumber +
        "&message=" +
        message;
  }

  static String getAllVisaApi(
    String token,
  ) {
    return mainApi + "/visa?token=" + token;
  }

  static String getAllTours(
    String token,
  ) {
    return mainApi + "/products?token=" + token;
  }

  static String userToursReservation = mainApi + "/posttour";
  static String userVisaReservation = mainApi + "/postvisa";

  static String trendingProducts = mainApi + "/trendingtours?token=";
  static String login = mainApi + "/login";
}
