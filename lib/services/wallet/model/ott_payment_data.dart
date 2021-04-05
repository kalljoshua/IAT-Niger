// To parse this JSON data, do
//
//     final ottData = ottDataFromMap(jsonString);

import 'dart:convert';

OttData ottDataFromMap(String str) => OttData.fromMap(json.decode(str));

String ottDataToMap(OttData data) => json.encode(data.toMap());

class OttData {
    OttData({
        this.contact,
        this.iatPackage,
        this.isp,
    });

    String contact;
    String iatPackage;
    int isp;

    factory OttData.fromMap(Map<String, dynamic> json) => OttData(
        contact: json["contact"],
        iatPackage: json["iatPackage"],
        isp: json["isp"],
    );

    Map<String, dynamic> toMap() => {
        "contact": contact,
        "iatPackage": iatPackage,
        "isp": isp,
    };
}
