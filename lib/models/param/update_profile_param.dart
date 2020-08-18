// To parse this JSON data, do
//
//     final updateProfileParam = updateProfileParamFromJson(jsonString);

import 'dart:convert';

UpdateProfileParam updateProfileParamFromJson(String str) => UpdateProfileParam.fromJson(json.decode(str));

String updateProfileParamToJson(UpdateProfileParam data) => json.encode(data.toJson());

class UpdateProfileParam {
    UpdateProfileParam({
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.shortBio,
        this.dateOfBirth,
    });

    String firstName;
    String lastName;
    String phone;
    String email;
    String shortBio;
    int dateOfBirth;

    factory UpdateProfileParam.fromJson(Map<String, dynamic> json) => UpdateProfileParam(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        shortBio: json["short_bio"] == null ? null : json["short_bio"],
        dateOfBirth: json["date_of_birth"] == null ? null : json["date_of_birth"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "short_bio": shortBio == null ? null : shortBio,
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
    };
}
