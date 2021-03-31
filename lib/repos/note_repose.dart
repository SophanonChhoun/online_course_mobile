import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/note.dart';
import 'package:online_tutorial/models/note_index.dart';
import 'package:online_tutorial/repos/api_repository.dart';

class NoteRepo extends ApiRepository {
  Future<NoteData> getByLessonId(int lessonId) async {
    final response = await http.get("$baseUrl/notes/lesson/$lessonId",
        headers: await getTokenHeader());

    if (response.statusCode == 200) {
      print("GET /notes?lesson_id=$lessonId successful");
      return compute(noteDataFromJson, response.body);
    } else if (response.statusCode == 204) {
      print("GET /notes?lesson_id=$lessonId returns no content");
      return NoteData();
    } else {
      print(response.body);
      throw Exception("GET /notes?lesson_id=$lessonId failed");
    }
  }

  Future<void> create({int lessonId, String content}) async {
    final response = await http.post("$baseUrl/notes",
        body: {'lesson_id': lessonId.toString(), 'content': content},
        headers: await getTokenHeader());

    if (response.statusCode == 201) {
      print("POST /notes successful");
    } else {
      print(response.body);
      throw Exception("POST /notes failed");
    }
  }

  Future<void> updateContent({int id, String content}) async {
    final response = await http.put("$baseUrl/notes/$id",
        body: {'content': content}, headers: await getTokenHeader());

    if (response.statusCode == 200) {
      print("UPDATE /notes/$id successful");
    } else {
      print(response.body);
      throw Exception("UPDATE /notes/$id failed");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete("$baseUrl/notes/$id",
        headers: await getTokenHeader());

    if (response.statusCode == 200) {
      print("DELETE /notes/$id successful");
    } else {
      throw Exception("DELETE /notes/$id failed");
    }
  }

  Future<NoteIndexData> getAll() async {
    final response =
        await http.get("$baseUrl/notes", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      print("GET /notes successful");
      return compute(noteIndexDataFromMap, response.body);
    } else {
      print(response.body);
      throw Exception("GET /notes failed");
    }
  }

  Future<NoteData> get(int id) async {
    final response =
        await http.get("$baseUrl/notes/$id", headers: await getTokenHeader());

    if (response.statusCode == 200) {
      print("GET /notes/$id successful");
      return compute(noteDataFromJson, response.body);
    } else {
      print(response.body);
      throw Exception("GET /notes/$id failed");
    }
  }
}
