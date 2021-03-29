import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/category.dart';
import 'package:online_tutorial/models/course.dart';
import 'api_repository.dart';

class CategoryRepo extends ApiRepository {
  Future<CategoryData> readDataCategory() async {
    http.Response response =
        await http.get("$baseUrl/category", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(categoryDataFromJson, body);
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<CategoryData> readDataUserCategory() async {
    http.Response response = await http.get("$baseUrl/user/category",
        headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(categoryDataFromJson, body);
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<CourseData> readDataRecentCourse() async {
    http.Response response =
        await http.get("$baseUrl/search/all", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(courseDataFromJson, body);
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<CourseData> readDataSearchCourse(search) async {
    http.Response response = await http
        .post("$baseUrl/search", headers: await getTokenHeader(), body: {
      "search": search,
    });
    if (response.statusCode == 200) {
      String body = response.body;
      return compute(courseDataFromJson, body);
    } else {
      throw Exception("Error while reading data");
    }
  }
}
