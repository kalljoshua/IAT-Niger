// To parse this JSON data, do
//
//     final profileData = profileDataFromJson(jsonString);

import 'dart:convert';

ProfileData profileDataFromJson(String str) => ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  ProfileData({
    this.contact,
    this.email,
    this.firstName,
    this.id,
    this.job,
    this.lastName,
    this.nin,
    this.residence,
  });

  String contact;
  String email;
  String firstName;
  int id;
  String job;
  String lastName;
  String nin;
  String residence;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    contact: json["contact"],
    email: json["email"],
    firstName: json["firstName"],
    id: json["id"],
    job: json["job"],
    lastName: json["lastName"],
    nin: json["nin"],
    residence: json["residence"],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact,
    "email": email,
    "firstName": firstName,
    "id": id,
    "job": job,
    "lastName": lastName,
    "nin": nin,
    "residence": residence,
  };
}
