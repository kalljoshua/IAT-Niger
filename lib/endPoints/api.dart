import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String all_authors_api = "/api/authors";
String all_categories_api = "/api/categories";
String all_posts_api = "/api/posts";

String categories_api = "/api/posts/categories/";

String posts_api = "/api/posts";

String single_post_api = "/api/post/{id}";

String post_comment_api = "/api/comments/posts/{id}";

class Api {
  getData(Uri apiUrl) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userToken = localStorage.getString('token');
    var response = await http.get(
      apiUrl,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $userToken",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  postDataHeader(data, Uri apiUrl) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userToken = sharedPreferences.getString('token');

    return await http.post(
      apiUrl,
      body: jsonEncode(data),
      headers: {
        HttpHeaders.authorizationHeader: userToken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
