import 'dart:convert';

SigninModel signinModelFromJson(String str) => SigninModel.fromJson(json.decode(str));

String signinModelToJson(SigninModel data) => json.encode(data.toJson());

class SigninModel {
    User user;

    SigninModel({
        this.user,
    });

    factory SigninModel.fromJson(Map<String, dynamic> json) => SigninModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    String email;
    String password;

    User({
        this.email,
        this.password,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
    };
}
