
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iat_nigeria/endPoints/end_points.dart';
import 'package:iat_nigeria/services/auth/user_signup_data.dart';
import 'package:iat_nigeria/session/session_storage.dart';

class AuthenticationService {
  http.Client client;
  SessionStorage sessionStorage;

  Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

  AuthenticationService(http.Client client, SessionStorage sessionStorage) {
    this.client = client;
    this.sessionStorage = sessionStorage;
  }

  Future<bool> login(String email, String password) async {
    
    Map<String, String> body = {"userName": email, "password": password};
    final msg = jsonEncode(body);

    var response =
    await http.post(EndPoints.getRegisteredUser(), headers: headers, body: msg);

    if (response.statusCode != 200) {      
      return false;
    }

    _createUserSession(response.body);
    return true;
  }


  Future<bool> signUpUser(UserSignUpData data) async {
    final msg = jsonEncode(data.toMap());
    final response =
    await client.post(EndPoints.getRegisterUserPath(), headers: headers, body: msg);

    if (response.statusCode != 200) {      
      return false;
    }
    
    _createUserSession(response.body);
    return true;
  }  

  _createUserSession(var responseData) {
    var jsonData = jsonDecode(responseData);
    var token = jsonData['jwt'];
    sessionStorage.createSession('token', token);
  }

  
}