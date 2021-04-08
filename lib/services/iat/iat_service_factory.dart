import 'package:http/http.dart' as http;
import 'package:iat_nigeria/session/session_storage.dart';

import 'iat_service.dart';

class IatServiceFactory {
  static IatService create(){
    var client = http.Client();
    var sessionStorage = new SessionStorage();
    return new IatService(client,sessionStorage);

  }
}