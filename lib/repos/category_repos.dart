import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/category.dart';

Future<CategoryData> readDataCategory() async {
  String url = "http://127.0.0.1:8000/api/category";

  http.Response response = await http.get(url, headers: {
    "Auth": "f9b8c2d87bc39552bfcb07372ec1ddaf33f7be3302c26f53a5363a93cf938883"
  });

  if (response.statusCode == 200) {
    String body = response.body;
    return compute(categoryDataFromJson, body);
  } else {
    throw Exception("Error while reading data");
  }
}
