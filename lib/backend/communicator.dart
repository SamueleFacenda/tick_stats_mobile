import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ExitCodeException implements Exception {
  final int exitCode;

  ExitCodeException(this.exitCode);
}

class Communicator{
  static const String urlServer = '192.168.68.118:8443';

  //singleton
  static final Communicator _communicator = Communicator._internal();
  factory Communicator() {
    return _communicator;
  }
  Communicator._internal();

  Future<int> login(String userName, String password) {
    LoginRequest body = LoginRequest(userName, password);
    print(body.toJson());

    final url = Uri.http(urlServer, '/authenticate');
    return http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body))
        .then((response) {
          if (response.statusCode != 200) {
            throw ExitCodeException(response.statusCode);
          }
          return jsonDecode(response.body);
        }).then((json) {
          print(json);
          String token = json['jwttoken'];
          print(token);
          _setToken(token);
          return 0;

        }).catchError((error) {
          print(error);
          if (error is ExitCodeException) {
            return error.exitCode;
          }
          return 600;
        });
  }

  void _setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setBool('logged', true);
  }

}

class LoginRequest {
  String username;
  String password;

  LoginRequest(this.username, this.password);

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}