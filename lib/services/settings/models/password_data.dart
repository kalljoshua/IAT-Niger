// To parse this JSON data, do
//
//     final passwordData = passwordDataFromJson(jsonString);

import 'dart:convert';

PasswordData passwordDataFromJson(String str) => PasswordData.fromJson(json.decode(str));

String passwordDataToJson(PasswordData data) => json.encode(data.toJson());

class PasswordData {
  PasswordData({
    this.confirm,
    this.newPass,
    this.oldPass,
  });

  String confirm;
  String newPass;
  String oldPass;

  factory PasswordData.fromJson(Map<String, dynamic> json) => PasswordData(
    confirm: json["confirm"],
    newPass: json["newPass"],
    oldPass: json["oldPass"],
  );

  Map<String, dynamic> toJson() => {
    "confirm": confirm,
    "newPass": newPass,
    "oldPass": oldPass,
  };
}
