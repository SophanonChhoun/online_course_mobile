import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/category.dart';

Future<CategoryData> readDataCategory() async {
  String url = "http://192.168.1.3:8000/api/category";

  http.Response response = await http.get(url, headers: {
    "Auth": "9090517a758514b48da649dfad45f7df505732c8c549ced47d8d4f2e09adc9ac"
  });

  if (response.statusCode == 200) {
    String body = response.body;
    return compute(categoryDataFromJson, body);
  } else {
    throw Exception("Error while reading data");
  }
}
