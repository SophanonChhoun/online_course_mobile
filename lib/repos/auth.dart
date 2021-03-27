import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_tutorial/models/auth_response.dart';

class AuthRepo {
  final baseUrl = "http://127.0.0.1:8000/api";

  Future<bool> signIn({String email, String password}) async {
    http.Response response = await http
        .post("$baseUrl/login", body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      AuthResponseData authResponse =
          await compute(authResponseDataFromMap, response.body);
      await _saveCredentials(authResponse);
      print("HelloBye");
      return true;
    } else {
      return false;
    }
  }

  Future<AuthResponseData> signUp(
      {String name,
      String email,
      String password,
      String passwordConfirmation}) async {
    http.Response response = await http.post("$baseUrl/register", body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    });

    if (response.statusCode == 200) {
      return compute(authResponseDataFromMap, response.body);
    } else {
      throw Exception("Sign up failed");
    }
  }

  signOut() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');
    await storage.delete(key: 'tokenExpiryDate');
  }

  Future<bool> verifyExistingCredentials() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    if (token == null) {
      return false;
    }
    DateTime tokenExpiryDate =
        DateTime.parse(await storage.read(key: 'tokenExpiryDate'));
    if (tokenExpiryDate.isBefore(DateTime.now())) {
      storage.delete(key: 'token');
      storage.delete(key: 'tokenExpiryDate');
      return false;
    }
    return true;
  }

  Future<void> _saveCredentials(AuthResponseData response) async {
    final storage = new FlutterSecureStorage();
    print("Saving token...");
    storage.write(key: 'token', value: response.data.token).then((value) {
      print("Token saved");

      print("Saving token expiry date...");
      DateTime now = DateTime.now();
      DateTime tokenExpiryDate =
          now.add(Duration(minutes: response.data.expiredAt));
      storage.write(key: 'tokenExpiryDate', value: tokenExpiryDate.toString());
      print("Token expiry date saved");
    });
  }
}