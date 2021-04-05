// To parse this JSON data, do
//
//     final flutterWave = flutterWaveFromJson(jsonString);

import 'dart:convert';

FlutterWave flutterWaveFromJson(String str) => FlutterWave.fromJson(json.decode(str));

String flutterWaveToJson(FlutterWave data) => json.encode(data.toJson());

class FlutterWave {
    FlutterWave({
        this.data,
        this.message,
        this.status,
    });

    Data data;
    String message;
    String status;

    factory FlutterWave.fromJson(Map<String, dynamic> json) => FlutterWave(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
    };
}

class Data {
    Data({
        this.link,
    });

    String link;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "link": link,
    };
}
