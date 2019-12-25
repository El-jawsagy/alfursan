import 'package:connectivity/connectivity.dart';

class ResourcesNotFound implements Exception {
  @override
  String toString() {
    return "Resources Not Found";
  }
}

class NoConnectionWithServer implements Exception {
  @override
  String toString() {
    return "Can't Connection With Server";
  }
}

class RedirectionFound implements Exception {
  @override
  String toString() {
    return "Too many redirection.";
  }
}

class WrongEmail implements Exception {
  @override
  String toString() {
    return "Your email is wrong.";
  }
}

class WrongPassword implements Exception {
  @override
  String toString() {
    return "Your Password is wrong.";
  }
}

class NoInterNetConnection implements Exception {
  @override
  String toString() {
    return "No Internet Conection";
  }
}

Future<String> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    throw NoInterNetConnection();
  }
  return "true";
}
