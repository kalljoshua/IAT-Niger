import 'dart:convert';

import 'package:iat_nigeria/utils/date_util.dart';


List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.idTeam,
    this.avatar,
    this.email,
    this.emailVerifiedAt,
    this.apiToken,
    this.likedPosts,
    this.dislikedPosts,
    this.favouritePosts,
    this.favouriteCategories,
    this.preferences,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String address;
  String phone;
  var idTeam;
  String avatar;
  String email;
  DateTime emailVerifiedAt;
  String apiToken;
  dynamic likedPosts;
  dynamic dislikedPosts;
  dynamic favouritePosts;
  dynamic favouriteCategories;
  dynamic preferences;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        idTeam: json["id_team"],
        avatar: json["avatar"],
        email: json["email"],
        emailVerifiedAt: DateUtil.getDate(json["email_verified_at"]),
        apiToken: json["api_token"],
        likedPosts: json["liked_posts"],
        dislikedPosts: json["disliked_posts"],
        favouritePosts: json["favourite_posts"],
        favouriteCategories: json["favourite_categories"],
        preferences: json["preferences"],
        createdAt: DateUtil.getDate(json["created_at"]),
        updatedAt: DateUtil.getDate(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "id_team": idTeam,
        "avatar": avatar,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "api_token": apiToken,
        "liked_posts": likedPosts,
        "disliked_posts": dislikedPosts,
        "favourite_posts": favouritePosts,
        "favourite_categories": favouriteCategories,
        "preferences": preferences,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
