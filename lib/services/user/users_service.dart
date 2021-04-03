

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iat_nigeria/endPoints/end_points.dart';
import 'package:iat_nigeria/models/user/numbers.dart';

class UsersService {
  http.Client client;

  UsersService(http.Client client) {
    this.client = client;
  }

  Future<Number> checkUserProfile(String userPhone) async {
    final response = await client.get(EndPoints.checkUserAvailable(userPhone));
      
    if (response.statusCode == 200) {   
      // If the call to the server was successful, parse the JSON.
      return Number.fromJson(jsonDecode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load user profile');
    }
  }
}