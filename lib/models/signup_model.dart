import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
    User user;

    SignupModel({
        this.user,
    });

    factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    String email;
    String password;
    String passwordConfirmation;
    String firstName;
    String lastName;

    User({
        this.email,
        this.password,
        this.passwordConfirmation,
        this.firstName,
        this.lastName,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        passwordConfirmation: json["password_confirmation"] == null ? null : json["password_confirmation"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "password_confirmation": passwordConfirmation == null ? null : passwordConfirmation,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
    };
}
