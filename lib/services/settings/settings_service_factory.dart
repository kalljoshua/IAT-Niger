import 'package:http/http.dart' as http;
import 'package:iat_nigeria/services/settings/settings_service.dart';
import 'package:iat_nigeria/session/session_storage.dart';

class SettingsServiceFactory {
  static SettingsService create(){
    var client = http.Client();
    var sessionStorage = new SessionStorage();
    return new SettingsService(client,sessionStorage);

  }
}