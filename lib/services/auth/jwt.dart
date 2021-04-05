import 'dart:convert';

Jwt jwtFromJson(String str) => Jwt.fromJson(json.decode(str));

String jwtToJson(Jwt data) => json.encode(data.toJson());

class Jwt {
    Jwt({
        this.jwt,
    });

    String jwt;

    factory Jwt.fromJson(Map<String, dynamic> json) => Jwt(
        jwt: json["jwt"],
    );

    Map<String, dynamic> toJson() => {
        "jwt": jwt,
    };
}
