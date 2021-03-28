import 'dart:convert';

UserData userDataFromMap(String str) => UserData.fromMap(json.decode(str));

String userDataToMap(UserData data) => json.encode(data.toMap());

class UserData {
  UserData({
    this.success,
    this.data,
  });

  bool success;
  User data;

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : User.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toMap(),
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
  });

  String firstName;
  String lastName;
  String email;

  factory User.fromMap(Map<String, dynamic> json) => User(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
      };
}
