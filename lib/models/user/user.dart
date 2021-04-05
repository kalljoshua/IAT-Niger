import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
        this.id,
        this.contact,
        this.email,
        this.name,
    });

    int id;
    String contact;
    String email;
    String name;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        contact: json["contact"],
        email: json["email"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contact": contact,
        "email": email,
        "name": name,
    };
}
