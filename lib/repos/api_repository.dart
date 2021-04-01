import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ApiRepository {
  final storage = new FlutterSecureStorage();
  final baseUrl = "http://192.168.1.168/api";

  Future<Map<String, String>> getTokenHeader() async {
    String token = await _getLocalToken();
    return {'Auth': "$token"};
  }

  Future<String> _getLocalToken() async {
    return await storage.read(key: "token");
  }
}
