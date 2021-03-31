import 'dart:convert';

NoteIndexData noteIndexDataFromMap(String str) =>
    NoteIndexData.fromMap(json.decode(str));

String noteIndexDataToMap(NoteIndexData data) => json.encode(data.toMap());

class NoteIndexData {
  NoteIndexData({
    this.success,
    this.data,
  });

  bool success;
  List<NoteIndex> data;

  factory NoteIndexData.fromMap(Map<String, dynamic> json) => NoteIndexData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<NoteIndex>.from(
                json["data"].map((x) => NoteIndex.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class NoteIndex {
  NoteIndex({
    this.id,
    this.course,
    this.lesson,
  });

  int id;
  String course;
  String lesson;

  factory NoteIndex.fromMap(Map<String, dynamic> json) => NoteIndex(
        id: json["id"] == null ? null : json["id"],
        course: json["course"] == null ? null : json["course"],
        lesson: json["lesson"] == null ? null : json["lesson"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "course": course == null ? null : course,
        "lesson": lesson == null ? null : lesson,
      };
}
