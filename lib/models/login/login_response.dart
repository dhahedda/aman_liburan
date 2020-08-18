import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    String status;
    String message;
    Data data;

    LoginResponse({
        this.status,
        this.message,
        this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    User user;

    Data({
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    String email;
    String firstname;
    String lastname;
    String avatarUrl;
    String authenticationToken;
    int walletbalance;

    User({
        this.email,
        this.firstname,
        this.lastname,
        this.avatarUrl,
        this.authenticationToken,
        this.walletbalance,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"] == null ? null : json["email"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
        authenticationToken: json["authentication_token"] == null ? null : json["authentication_token"],
        walletbalance: json["walletbalance"] == null ? null : json["walletbalance"],
    );

    Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "avatar_url": avatarUrl == null ? null : avatarUrl,
        "authentication_token": authenticationToken == null ? null : authenticationToken,
        "walletbalance": walletbalance == null ? null : walletbalance,
    };
}
