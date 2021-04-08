import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iat_nigeria/endPoints/end_points.dart';
import 'package:iat_nigeria/services/iat/models/iat_data.dart';
import 'package:iat_nigeria/session/session_storage.dart';

class IatService {
  http.Client client;

  SessionStorage sessionStorage;

  IatService(http.Client client, SessionStorage sessionStorage) {
    this.client = client;
    this.sessionStorage = sessionStorage;
  }

  Future<IatData> getUserIatInfo() async {
    String userToken =  await sessionStorage.getToken();
    print("***User token: "+userToken);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final response =
    await client.get(EndPoints.getUserIat(), headers: headers);
    print("***Response body: "+response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      print("***Response body: "+response.statusCode.toString());
      return IatData.fromJson(jsonDecode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load user wallet');
    }
  }

}