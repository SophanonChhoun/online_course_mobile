import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/lesson.dart';
import 'package:online_tutorial/models/lessondata.dart';
import 'package:online_tutorial/repos/api_repository.dart';

class CourseDetailRepo extends ApiRepository {
  Future<CourseDetailData> readDataCourseDetail(id) async {
    http.Response response =
        await http.get("$baseUrl/courses/$id", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      String body = response.body;
      return compute(courseDetailDataFromJson, body);
    } else {
      throw Exception("Error while reading data");
    }
  }

  Future<bool> writeEnrollCourse(id) async {
    http.Response response = await http.post(
      "$baseUrl/user/courses",
      headers: await getTokenHeader(),
      body: {
        "course_id": id.toString(),
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Error while writing: ${response.statusCode}");
    }
  }

  Future<bool> deleteEnrollCourse(id) async {
    http.Response response = await http.delete(
      "$baseUrl/user/courses?course_id=$id",
      headers: await getTokenHeader(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Error while writing: ${response.statusCode}");
    }
  }

  Future<LessonData> readLessonData(id) async {
    http.Response response =
        await http.get("$baseUrl/lessons/$id", headers: await getTokenHeader());
    if (response.statusCode == 200) {
      String body = response.body;
      return compute(lessonDataFromMap, body);
    } else {
      throw Exception("Error while reading data");
    }
  }
}
