import 'package:http/http.dart' as http;
import 'package:iat_nigeria/session/session_storage.dart';

import 'auth_service.dart';

class AuthServiceFactory {
  static AuthenticationService create() {
    var client = http.Client();
    var sessionStorage = new SessionStorage();
    return new AuthenticationService(client,sessionStorage);
  }
}
