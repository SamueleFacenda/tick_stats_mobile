import 'package:http/http.dart' as http;
import 'dart:convert';


class Communicator{
  static const String urlServer = 'localhost:8443';

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
        .then((response) => jsonDecode(response.body))
        .then((json) {
      print(json);
      String token = json['jwttoken'];
      print(token);
      return json.statusCode;
    });
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