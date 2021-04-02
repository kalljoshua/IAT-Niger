import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  Future<SharedPreferences> createSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  void createSession(var user, var token) async {
    SharedPreferences sharedPreferences = await createSharedPreferences();
    sharedPreferences.setString("user", json.encode(user));
    sharedPreferences.setString("token", token);
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await createSharedPreferences();
    return sharedPreferences.getString('token');
  }

  /* Future<User> getUser() async {
    SharedPreferences sharedPreferences = await createSharedPreferences();
    String userJson = sharedPreferences.getString('user');
    Map<String, dynamic> userMap = json.decode(userJson);
    return User.fromJson(userMap);
  }
 */
  loginStatus() async {
    SharedPreferences sharedPreferences = await createSharedPreferences();
    return sharedPreferences.getString("token") != null ? true : false;
  }

  void logout() async {
    SharedPreferences sharedPreferences = await createSharedPreferences();
    sharedPreferences.clear();
  }
}
