
import 'package:http/http.dart' as http;
import 'package:iat_nigeria/session/session_storage.dart';

import 'wallet_service.dart';

class WalletServiceFactory {
  static WalletService create() {
    var client = http.Client();
    var sessionStorage = new SessionStorage();
    return new WalletService(client,sessionStorage);
  }
}