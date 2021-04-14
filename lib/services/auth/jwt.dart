import 'dart:convert';

JwtToken jwtFromJson(String str) => JwtToken.fromJson(json.decode(str));

String jwtToJson(JwtToken data) => json.encode(data.toJson());

class JwtToken {
    JwtToken({
        this.jwt,
    });

    String jwt;

    factory JwtToken.fromJson(Map<String, dynamic> json) => JwtToken(
        jwt: json["jwt"],
    );

    Map<String, dynamic> toJson() => {
        "jwt": jwt,
    };
}
