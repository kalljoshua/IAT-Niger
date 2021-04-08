// To parse this JSON data, do
//
//     final iatData = iatDataFromJson(jsonString);

import 'dart:convert';

IatData iatDataFromJson(String str) => IatData.fromJson(json.decode(str));

String iatDataToJson(IatData data) => json.encode(data.toJson());

class IatData {
  IatData({
    this.contact,
    this.expireAt,
    this.id,
    this.lastTransaction,
  });

  String contact;
  String expireAt;
  int id;
  int lastTransaction;

  factory IatData.fromJson(Map<String, dynamic> json) => IatData(
    contact: json["contact"],
    expireAt: json["expireAt"],
    id: json["id"],
    lastTransaction: json["lastTransaction"],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact,
    "expireAt": expireAt,
    "id": id,
    "lastTransaction": lastTransaction,
  };
}
