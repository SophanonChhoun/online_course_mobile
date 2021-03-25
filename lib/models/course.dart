// To parse this JSON data, do
//
//     final courseData = courseDataFromMap(jsonString);

import 'dart:convert';

import 'package:online_tutorial/models/author.dart';

CourseData courseDataFromJson(String str) =>
    CourseData.fromJson(json.decode(str));

String courseDataToMap(CourseData data) => json.encode(data.toMap());

class CourseData {
  CourseData({
    this.success,
    this.data,
  });

  bool success;
  List<Course> data;

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Course>.from(json["data"].map((x) => Course.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Course {
  Course({
    this.id,
    this.headerImg,
    this.title,
    this.description,
    this.author,
    this.category,
    this.duration,
    this.numberOfLessons,
  });

  int id;
  String headerImg;
  String title;
  String description;
  Author author;
  String category;
  dynamic duration;
  dynamic numberOfLessons;

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"] == null ? null : json["id"],
        headerImg: json["header_img"] == null ? null : json["header_img"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        author: json["author"] == null ? null : Author.fromMap(json["author"]),
        category: json["category"] == null ? null : json["category"],
        duration: json["duration"],
        numberOfLessons: json["number_of_lessons"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "header_img": headerImg == null ? null : headerImg,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "author": author == null ? null : author.toMap(),
        "category": category == null ? null : category,
        "duration": duration,
        "number_of_lessons": numberOfLessons,
      };
}
