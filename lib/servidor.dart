import 'dart:convert';
import 'package:http/http.dart' as http;

class Servidor {
  var baseURL = 'http://localhost:3000';
  var url;

    Future<String?> login(String email, String password) async {
    var url = '$baseURL/utilizador/login';

    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email_param': email,
        'pass_param': password,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      String? token = responseBody['token'];

      return token;
    } else {
      return null;
    }
  }


}
