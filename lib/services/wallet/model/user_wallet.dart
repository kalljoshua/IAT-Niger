// To parse this JSON data, do
//
//     final userWallet = userWalletFromJson(jsonString);

import 'dart:convert';

List<UserWallet> userWalletFromJson(String str) => List<UserWallet>.from(json.decode(str).map((x) => UserWallet.fromJson(x)));

String userWalletToJson(List<UserWallet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserWallet {
    UserWallet({
        this.balance,
        this.contact,
        this.id,
        this.lastPayment,
        this.uid,
    });

    var balance;
    String contact;
    int id;
    int lastPayment;
    int uid;

    factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        balance: json["balance"],
        contact: json["contact"],
        id: json["id"],
        lastPayment: json["lastPayment"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
        "contact": contact,
        "id": id,
        "lastPayment": lastPayment,
        "uid": uid,
    };
}
