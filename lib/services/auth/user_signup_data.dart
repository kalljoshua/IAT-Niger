class UserSignUpData {
    UserSignUpData({
        this.contact,
        this.email,
        this.passWord,
    });

    String contact;
    String email;
    String passWord;

    factory UserSignUpData.fromMap(Map<String, dynamic> json) => UserSignUpData(
        contact: json["contact"],
        email: json["email"],
        passWord: json["passWord"],
    );

    Map<String, dynamic> toMap() => {
        "contact": contact,
        "email": email,
        "passWord": passWord,
    };
}
