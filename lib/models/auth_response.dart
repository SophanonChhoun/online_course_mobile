import 'dart:convert';

AuthResponseData authResponseDataFromMap(String str) =>
    AuthResponseData.fromMap(json.decode(str));

String authResponseDataToMap(AuthResponseData data) =>
    json.encode(data.toMap());

class AuthResponseData {
  AuthResponseData({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory AuthResponseData.fromMap(Map<String, dynamic> json) =>
      AuthResponseData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  Data({
    this.token,
    this.expiredAt,
    this.email,
    this.firstName,
    this.lastName,
  });

  String token;
  int expiredAt;
  String email;
  String firstName;
  String lastName;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? null : json["token"],
        expiredAt: json["expired_at"] == null ? null : json["expired_at"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "token": token == null ? null : token,
        "expired_at": expiredAt == null ? null : expiredAt,
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
      };
}
