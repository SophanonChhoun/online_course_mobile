// To parse this JSON data, do
//
//     final courseDetailData = courseDetailDataFromMap(jsonString);

import 'dart:convert';

import 'package:online_tutorial/models/author.dart';

CourseDetailData courseDetailDataFromJson(String str) =>
    CourseDetailData.fromJson(json.decode(str));

String courseDetailDataToMap(CourseDetailData data) =>
    json.encode(data.toMap());

class CourseDetailData {
  CourseDetailData({
    this.success,
    this.data,
  });

  bool success;
  CourseDetail data;

  factory CourseDetailData.fromJson(Map<String, dynamic> json) =>
      CourseDetailData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : CourseDetail.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toMap(),
      };
}

class CourseDetail {
  CourseDetail({
    this.id,
    this.headerImage,
    this.title,
    this.description,
    this.author,
    this.duration,
    this.numberOfLessons,
    this.enroll,
    this.lessons,
  });

  int id;
  String headerImage;
  String title;
  String description;
  Author author;
  String duration;
  int numberOfLessons;
  bool enroll;
  List<Lesson> lessons;

  factory CourseDetail.fromMap(Map<String, dynamic> json) => CourseDetail(
        id: json["id"] == null ? null : json["id"],
        headerImage: json["header_image"] == null ? null : json["header_image"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        author: json["author"] == null ? null : Author.fromMap(json["author"]),
        duration: json["duration"] == null ? null : json["duration"],
        numberOfLessons: json["number_of_lessons"] == null
            ? null
            : json["number_of_lessons"],
        enroll: json["enroll"] == null ? null : json["enroll"],
        lessons: json["lessons"] == null
            ? null
            : List<Lesson>.from(json["lessons"].map((x) => Lesson.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "header_image": headerImage == null ? null : headerImage,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "author": author == null ? null : author.toMap(),
        "duration": duration == null ? null : duration,
        "number_of_lessons": numberOfLessons == null ? null : numberOfLessons,
        "enroll": enroll == null ? null : enroll,
        "lessons": lessons == null
            ? null
            : List<dynamic>.from(lessons.map((x) => x.toMap())),
      };
}

class Lesson {
  Lesson({
    this.id,
    this.title,
    this.duration,
    this.videoUrl,
    this.textContent,
    this.videoContent,
    this.number,
  });

  int id;
  String title;
  int duration;
  String videoUrl;
  dynamic textContent;
  String videoContent;
  int number;

  factory Lesson.fromMap(Map<String, dynamic> json) => Lesson(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        duration: json["duration"] == null ? null : json["duration"],
        videoUrl: json["video_url"] == null ? null : json["video_url"],
        textContent: json["text_content"],
        videoContent:
            json["video_content"] == null ? null : json["video_content"],
        number: json["number"] == null ? null : json["number"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "duration": duration == null ? null : duration,
        "video_url": videoUrl == null ? null : videoUrl,
        "text_content": textContent,
        "video_content": videoContent == null ? null : videoContent,
        "number": number == null ? null : number,
      };
}
