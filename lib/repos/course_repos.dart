import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/course.dart';

Future<CourseData> readDataUserCourse() async {
  String url = "http://127.0.0.1:8000/api/user/courses";

  http.Response response = await http.get(url, headers: {
    "Auth": "0ff34049c87258dabeb1ce776da717df75d3f434443ecbd4678d0222bf0537ed"
  });

  if (response.statusCode == 200) {
    String body = response.body;
    return compute(courseDataFromJson, body);
  } else {
    throw Exception("Error while reading data");
  }
}

Future<CourseData> readDataAllCourse() async {
  String url = "http://127.0.0.1:8000/api/courses";

  http.Response response = await http.get(url, headers: {
    "Auth": "0ff34049c87258dabeb1ce776da717df75d3f434443ecbd4678d0222bf0537ed"
  });
  print("Hello");
  if (response.statusCode == 200) {
    String body = response.body;
    return compute(courseDataFromJson, body);
  } else {
    throw Exception("Error while reading data");
  }
}
