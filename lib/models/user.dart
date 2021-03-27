import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
  });

  int id;
  String first_name;
  String last_name;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
      };
}
