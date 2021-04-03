import 'dart:convert';

List<Number> numberFromJson(String str) => List<Number>.from(json.decode(str).map((x) => Number.fromJson(x)));

String numberToJson(List<Number> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Number {
    Number({
        this.contact,
        this.status,
    });

    String contact;
    String status;

    factory Number.fromJson(Map<String, dynamic> json) => Number(
        contact: json["contact"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "contact": contact,
        "status": status,
    };
}
