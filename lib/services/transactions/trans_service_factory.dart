import 'package:http/http.dart' as http;
import 'package:iat_nigeria/session/session_storage.dart';

import 'transaction_service.dart';

class TransactionServiceFactory {
  static TransactionService create(){
    var client = http.Client();
    var sessionStorage = new SessionStorage();
    return new TransactionService(client,sessionStorage);

  }
}