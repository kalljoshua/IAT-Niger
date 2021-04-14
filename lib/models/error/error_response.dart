// To parse this JSON data, do
//
//     final errorData = errorDataFromJson(jsonString);

import 'dart:convert';

ErrorData errorDataFromJson(String str) => ErrorData.fromJson(json.decode(str));

String errorDataToJson(ErrorData data) => json.encode(data.toJson());

class ErrorData {
  ErrorData({
    this.timeStamp,
    this.message,
    this.description,
    this.details,
  });

  int timeStamp;
  String message;
  String description;
  dynamic details;

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
    timeStamp: json["timeStamp"],
    message: json["message"],
    description: json["description"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "timeStamp": timeStamp,
    "message": message,
    "description": description,
    "details": details,
  };
}
