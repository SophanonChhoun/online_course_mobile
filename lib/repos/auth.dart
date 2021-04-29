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

      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp({String name, String email, String password}) async {
    http.Response response = await http.post("$baseUrl/register", body: {
      'first_name': name.split(" ")[0] ?? null,
      'last_name': name.split(" ")[1] ?? null,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      print("Sign up successful. Computing response...");
      AuthResponseData authResponse =
          await compute(authResponseDataFromMap, response.body);
      print("Saving credentials...");
      await _saveCredentials(authResponse);
      print("Saving credentials done");
      return true;
    } else {
      print("Sign up failed");
      print(response.body);
      return false;
    }
  }

  Future<void> signOut() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');
    await storage.delete(key: 'tokenExpiryDate');
    print("Sign out done");
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
      print("error");
      storage.delete(key: 'token');
      storage.delete(key: 'tokenExpiryDate');
      return false;
    }
    print("Bye");
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
