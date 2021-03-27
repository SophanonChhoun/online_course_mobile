import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/course.dart';
import 'package:online_tutorial/repos/api_repository.dart';

class CourseRepo extends ApiRepository {
  Future<CourseData> readDataUserCourse() async {
    http.Response response = await http.get("$baseUrl/user/courses",
        headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(courseDataFromJson, body);
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<CourseData> readDataAllCourse() async {
    http.Response response = await http.get(
      "$baseUrl/courses",
      headers: await getTokenHeader(),
    );
    print("Hello");
    if (response.statusCode == 200) {
      String body = response.body;
      return compute(courseDataFromJson, body);
    } else {
      throw Exception("Error while reading data");
    }
  }
}
