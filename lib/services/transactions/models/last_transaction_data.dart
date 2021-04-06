// To parse this JSON data, do
//
//     final paymentsData = paymentsDataFromJson(jsonString);

import 'dart:convert';

List<PaymentsData> paymentsDataFromJson(String str) => List<PaymentsData>.from(json.decode(str).map((x) => PaymentsData.fromJson(x)));

String paymentsDataToJson(List<PaymentsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentsData {
    PaymentsData({
        this.amount,
        this.creationDateTime,
        this.externalId,
        this.id,
        this.message,
        this.paymentDate,
        this.paymentMethod,
        this.paymentType,
        this.ref,
        this.status,
        this.walletId,
    });

    double amount;
    DateTime creationDateTime;
    String externalId;
    int id;
    String message;
    String paymentDate;
    String paymentMethod;
    String paymentType;
    String ref;
    String status;
    int walletId;

    factory PaymentsData.fromJson(Map<String, dynamic> json) => PaymentsData(
        amount: json["amount"],
        creationDateTime: DateTime.parse(json["creationDateTime"]),
        externalId: json["externalId"],
        id: json["id"],
        message: json["message"],
        paymentDate: json["paymentDate"],
        paymentMethod: json["paymentMethod"],
        paymentType: json["paymentType"],
        ref: json["ref"],
        status: json["status"],
        walletId: json["walletId"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "creationDateTime": creationDateTime.toIso8601String(),
        "externalId": externalId,
        "id": id,
        "message": message,
        "paymentDate": paymentDate,
        "paymentMethod": paymentMethod,
        "paymentType": paymentType,
        "ref": ref,
        "status": status,
        "walletId": walletId,
    };
}
