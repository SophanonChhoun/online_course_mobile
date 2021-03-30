import 'dart:convert';

NoteData noteDataFromJson(String str) => NoteData.fromMap(json.decode(str));

String noteDataToJson(NoteData data) => json.encode(data.toMap());

class NoteData {
  NoteData({
    this.success,
    this.data,
  });

  bool success;
  Note data;

  factory NoteData.fromMap(Map<String, dynamic> json) => NoteData(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Note.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toMap(),
      };
}

class Note {
  Note({
    this.id,
    this.content,
  });

  int id;
  String content;

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json["id"] == null ? null : json["id"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "content": content == null ? null : content,
      };
}
