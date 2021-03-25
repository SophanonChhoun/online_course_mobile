import 'dart:convert';

import 'course.dart';

CategoryData categoryDataFromJson(String str) =>
    CategoryData.fromJson(json.decode(str));

String categoryDataToMap(CategoryData data) => json.encode(data.toMap());

class CategoryData {
  CategoryData({
    this.success,
    this.data,
  });

  bool success;
  List<Category> data;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Category {
  Category({
    this.name,
    this.courses,
  });

  String name;
  List<Course> courses;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        name: json["name"] == null ? null : json["name"],
        courses: json["courses"] == null
            ? null
            : List<Course>.from(json["courses"].map((x) => Course.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "courses": courses == null
            ? null
            : List<dynamic>.from(courses.map((x) => x.toMap())),
      };
}
