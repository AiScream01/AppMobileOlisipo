import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Servidor {
  var baseURL = 'https://olisipo-8h6f.onrender.com';
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

Future<void> inserirAjudaCusto(
  String? token,
  double valorAjuda,
  String descritivoAjuda,
  String faturaAjuda,
  //bool confirmacaoAjudas,
) async {
  var url = '$baseURL/ajudascusto/create/';

  var response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'custo_param': valorAjuda,
      'descricao_param': descritivoAjuda,
      'comprovativo_param': faturaAjuda,
    }),
  );

  if (response.statusCode == 200) {
    print('Ajudas de Custo inseridas com sucesso!');
  } else {
    print('Erro em Ajudas de Custo inseridas: ${response.statusCode}');
    throw Exception('Falha ao inserir Ajudas de Custo inseridas');
  }
}



  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String?> obterTokenLocalmente() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
