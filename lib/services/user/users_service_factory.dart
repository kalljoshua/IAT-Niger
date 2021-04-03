
import 'package:http/http.dart' as http;
import 'package:iat_nigeria/services/user/users_service.dart';

class UsersServiceFactory {
  static UsersService create() {
    var client = http.Client();
    return new UsersService(client);
  }
}
