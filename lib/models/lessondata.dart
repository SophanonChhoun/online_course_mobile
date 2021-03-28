// To parse this JSON data, do
//
//     final lessonData = lessonDataFromMap(jsonString);

import 'dart:convert';

import 'package:online_tutorial/models/lesson.dart';

LessonData lessonDataFromMap(String str) =>
    LessonData.fromMap(json.decode(str));

String lessonDataToMap(LessonData data) => json.encode(data.toMap());

class LessonData {
  LessonData({
    this.success,
    this.data,
  });

  bool success;
  Lesson data;

  factory LessonData.fromMap(Map<String, dynamic> json) => LessonData(
        success: json["success"],
        data: Lesson.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
      };
}
