import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/models/data_message.dart';
import 'package:online_tutorial/models/user.dart';
import 'package:online_tutorial/repos/api_repository.dart';

class UserRepo extends ApiRepository {
  Future<UserData> readDataUser() async {
    http.Response response = await http.get("$baseUrl/user/profile",
        headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(userDataFromMap, body);
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<bool> updateUserName(firstName, lastName) async {
    http.Response response = await http
        .put("$baseUrl/user/profile", headers: await getTokenHeader(), body: {
      "first_name": firstName,
      "last_name": lastName,
    });
    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<bool> updateUserEmail(email) async {
    http.Response response = await http
        .put("$baseUrl/user/profile", headers: await getTokenHeader(), body: {
      "email": email,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<DataMessage> updateUserPassword(new_password, old_password) async {
    http.Response response = await http.put("$baseUrl/user/profile/password",
        headers: await getTokenHeader(),
        body: {
          "new_password": new_password,
          "old_password": old_password,
        });
    if (response.statusCode == 200) {
      return compute(dataMessageFromMap, response.body);
    } else {
      throw Exception("Error while reading data");
    }
  }
}
