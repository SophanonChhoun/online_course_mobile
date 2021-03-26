import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/category.dart';
import 'package:online_tutorial/models/course.dart';

Future<CategoryData> readDataCategory() async {
  String url = "http://127.0.0.1:8000/api/category";

  http.Response response = await http.get(url, headers: {
    "Auth": "661f7b36246609127ab6bae5519ffb0702de9adda1176c28f8a823428fe3cf2b"
  });

  if (response.statusCode == 200) {
    String body = response.body;
    return compute(categoryDataFromJson, body);
  } else {
    throw Exception("Error while reading data");
  }
}

Future<CourseData> readDataRecentCourse() async {
  String url = "http://127.0.0.1:8000/api/search/all";

  http.Response response = await http.get(url, headers: {
    "Auth": "661f7b36246609127ab6bae5519ffb0702de9adda1176c28f8a823428fe3cf2b"
  });

  if (response.statusCode == 200) {
    String body = response.body;
    return compute(courseDataFromJson, body);
  } else {
    throw Exception("Error while reading data");
  }
}

Future<CourseData> readDataSearchCourse(search) async {
  String url = "http://127.0.0.1:8000/api/search";

  http.Response response = await http.post(url, headers: {
    "Auth": "661f7b36246609127ab6bae5519ffb0702de9adda1176c28f8a823428fe3cf2b"
  }, body: {
    "search": search,
  });
  if (response.statusCode == 200) {
    String body = response.body;
    return compute(courseDataFromJson, body);
  } else {
    throw Exception("Error while reading data");
  }
}
