import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iat_nigeria/endPoints/end_points.dart';
import 'package:iat_nigeria/services/settings/models/password_data.dart';
import 'package:iat_nigeria/session/session_storage.dart';

class SettingsService {
  http.Client client;

  SessionStorage sessionStorage;

  SettingsService(http.Client client, SessionStorage sessionStorage) {
    this.client = client;
    this.sessionStorage = sessionStorage;
  }

  Future<bool> updatePassword(PasswordData data) async {
    String userToken =  await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final msg = jsonEncode(data.toJson());
    final response =
    await client.put(EndPoints.updatePasswordPath(), headers: headers, body: msg);

    print("***Response Code: "+response.statusCode.toString());

    if (response.statusCode != 200) {
      print("***Response body: "+response.body);
      return false;
    }
    //_createUserSession(response.body);
    return true;
  }

}