import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Servidor {
  final String baseURL = 'https://olisipo-8h6f.onrender.com';
  final String apiUrl =
      "https://api.suaempresa.com"; // Substituir pela URL real da API

  // Método para requisições GET
  Future<http.Response> _get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await http.get(Uri.parse('$baseURL$endpoint'), headers: headers);
      return response;
    } catch (e) {
      print('Erro na requisição GET: $e');
      throw Exception('Erro na requisição GET');
    }
  }

  // Método para requisições POST
  Future<http.Response> _post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      print('Erro na requisição POST: $e');
      throw Exception('Erro na requisição POST');
    }
  }

  // Método para requisições PUT
  Future<http.Response> _put(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseURL$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      print('Erro na requisição PUT: $e');
      throw Exception('Erro na requisição PUT');
    }
  }

  // Método de login
  Future<String?> login(String email, String password) async {
    var url = '/utilizador/login';
    try {
      var response =
          await _post(url, {'email_param': email, 'pass_param': password});
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        String? token = responseBody['token'];
        if (token != null) {
          await saveToken(token);
        }
        return token;
      } else {
        print('Erro no login: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
      return null;
    }
  }

  // Método para inserir ajuda de custo
  Future<void> inserirAjudaCusto(String? token, double valorAjuda,
      String descritivoAjuda, String faturaAjuda) async {
    var url = '/ajudascusto/create/';
    try {
      var response = await _post(
        url,
        {
          'custo_param': valorAjuda,
          'descricao_param': descritivoAjuda,
          'comprovativo_param': faturaAjuda,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        print('Ajudas de Custo inseridas com sucesso!');
      } else {
        print('Erro ao inserir Ajudas de Custo: ${response.statusCode}');
        throw Exception('Falha ao inserir Ajudas de Custo');
      }
    } catch (e) {
      print('Erro ao inserir Ajuda de Custo: $e');
    }
  }

  // Método para enviar despesas de viatura
  Future<bool> enviarDespesasViatura({
    required String partida,
    required String chegada,
    required String quilometros,
    required String portagens,
    String? comprovativoPath,
  }) async {
    try {
      var uri = Uri.parse('$apiUrl/despesas_viatura');

      var request = http.MultipartRequest('POST', uri);

      request.fields['partida'] = partida;
      request.fields['chegada'] = chegada;
      request.fields['quilometros'] = quilometros;
      request.fields['portagens'] = portagens;

      if (comprovativoPath != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'comprovativo',
          comprovativoPath,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Erro ao enviar despesas: $e");
      return false;
    }
  }

  // Método para enviar uma falta
  Future<bool> enviarFalta({
    required String data,
    required String descricao,
    String? comprovativoPath,
  }) async {
    try {
      var uri = Uri.parse('$apiUrl/faltas');

      var request = http.MultipartRequest('POST', uri);

      request.fields['data'] = data;
      request.fields['descricao'] = descricao;

      if (comprovativoPath != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'comprovativo',
          comprovativoPath,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Erro ao enviar falta: $e");
      return false;
    }
  }

  // Método para salvar o token
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Método para obter o token localmente
  Future<String?> obterTokenLocalmente() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Método para remover o token
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Método para obter dados utilizador
  Future<void> obterDadosUsuario() async {
    var url = '/utilizador/dados';
    try {
      String? token = await obterTokenLocalmente();
      if (token == null) {
        print('Token não encontrado. Faça login novamente.');
        return;
      }
      var response =
          await _get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var dados = json.decode(response.body);
        print('Dados do usuário: $dados');
      } else {
        print('Erro ao obter dados do usuário: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao obter dados do usuário: $e');
    }
  }

  // Método para atualizar senha
  Future<void> atualizarSenha(String novaSenha) async {
    var url = '/utilizador/atualizarSenha';
    try {
      String? token = await obterTokenLocalmente();
      if (token == null) {
        print('Token não encontrado. Faça login novamente.');
        return;
      }
      var response = await _put(
        url,
        {'senha_param': novaSenha},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        print('Senha atualizada com sucesso!');
      } else {
        print('Erro ao atualizar senha: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao atualizar senha: $e');
    }
  }

  // Método para obter notícias
  Future<List<dynamic>> obterNoticias() async {
    var url = '/noticias'; // Substitua com o endpoint real para notícias
    try {
      var response = await _get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro ao obter notícias: ${response.statusCode}');
        throw Exception('Erro ao obter notícias');
      }
    } catch (e) {
      print('Erro ao obter notícias: $e');
      throw Exception('Erro ao obter notícias');
    }
  }
}
