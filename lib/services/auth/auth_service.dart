
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iat_nigeria/endPoints/end_points.dart';
import 'package:iat_nigeria/services/auth/user_signup_data.dart';
import 'package:iat_nigeria/session/session_storage.dart';

class AuthenticationService {
  http.Client client;
  SessionStorage sessionStorage;

  AuthenticationService(http.Client client, SessionStorage sessionStorage) {
    this.client = client;
    this.sessionStorage = sessionStorage;
  }

  Future<bool> login(String email, String password) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, String> body = {"email": email, "password": password};

    var response =
    await http.post(EndPoints.createPost(), headers: headers, body: body);

    if (response.statusCode != 200) {
      return false;
    }

    _createUserSession(response.body);
    return true;
  }


  Future<bool> signUpUser(UserSignUpData data) async {
    final response =
    await client.post(EndPoints.getRegisterUserPath(), body: data.toMap());

    if (response.statusCode != 201) {
      return false;
    }
    _createUserSession(response.body);
    return true;
  }  

  _createUserSession(var responseData) {
    var jsonData = jsonDecode(responseData);
    var token = jsonData['token'];
    sessionStorage.createSession(jsonData['user'], token);
  }

  
}