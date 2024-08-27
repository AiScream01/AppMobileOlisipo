import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Servidor {
  final String baseURL = 'https://pi4-api.onrender.com'; // URL base principal

  // =========================
  //     Métodos HTTP Básicos
  // =========================

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

  // Método para requisições DELETE
  Future<http.Response> _delete(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseURL$endpoint'), headers: headers);
      return response;
    } catch (e) {
      print('Erro na requisição DELETE: $e');
      throw Exception('Erro na requisição DELETE');
    }
  }

  // =========================
  //    Autenticação e Tokens
  // =========================

  // Método para login
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

  // Método para salvar o token localmente
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

  // =========================
  //         Parcerias
  // =========================

  // Obter lista de parcerias
  Future<List<dynamic>> obterParcerias() async {
    var url = '/parcerias';
    try {
      var response = await _get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro ao obter lista de parcerias: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erro ao obter lista de parcerias: $e');
      return [];
    }
  }

  // Obter detalhes de uma parceria específica
  Future<Map<String, dynamic>?> obterDetalhesParceria(String idParceria) async {
    var url = '/parcerias/$idParceria';
    try {
      var response = await _get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro ao obter detalhes da parceria: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao obter detalhes da parceria: $e');
      return null;
    }
  }

  // =========================
  //     Ajudas de Custo
  // =========================

  // Inserir uma ajuda de custo
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

  // =========================
  //    Despesas de Viatura
  // =========================

  // Enviar despesas de viatura
  Future<bool> enviarDespesasViatura({
    required String token,
    required String partida,
    required String chegada,
    required double quilometros,
    required double portagens,
    String? comprovativoPath,
  }) async {
    try {
      var uri = Uri.parse('$baseURL/despesas_viatura');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['partida'] = partida;
      request.fields['chegada'] = chegada;
      request.fields['quilometros'] = quilometros.toString();
      request.fields['portagens'] = portagens.toString();

      if (comprovativoPath != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'comprovativo',
          comprovativoPath,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Despesas de viatura enviadas com sucesso!');
        return true;
      } else {
        print('Erro ao enviar despesas de viatura: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Erro ao enviar despesas de viatura: $e");
      return false;
    }
  }

  // =========================
  //          Faltas
  // =========================

  // Enviar uma falta
  Future<bool> enviarFalta({
    required String token,
    required String data,
    required String descricao,
    String? comprovativoPath,
  }) async {
    try {
      var uri = Uri.parse('$baseURL/faltas');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['data'] = data;
      request.fields['descricao'] = descricao;

      if (comprovativoPath != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'comprovativo',
          comprovativoPath,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Falta enviada com sucesso!');
        return true;
      } else {
        print('Erro ao enviar falta: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Erro ao enviar falta: $e");
      return false;
    }
  }

  // =========================
  //          Férias
  // =========================

  // Enviar Pedido de Férias
  Future<bool> enviarPedidoFerias({
    required String token,
    required DateTime dataInicio,
    required DateTime dataFim,
  }) async {
    var url = '/ferias/solicitar'; // Atualize o endpoint conforme necessário
    try {
      var response = await _post(
        url,
        {
          'data_inicio': dataInicio.toIso8601String(),
          'data_fim': dataFim.toIso8601String(),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Pedido de férias enviado com sucesso!');
        return true;
      } else {
        print('Erro ao enviar pedido de férias: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro ao enviar pedido de férias: $e');
      return false;
    }
  }

  // Obter Pedidos de Férias
  Future<List<dynamic>> obterPedidosFerias({required String token}) async {
    var url = '/ferias'; // Atualize o endpoint conforme necessário
    try {
      var response = await _get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print('Pedidos de férias obtidos com sucesso!');
        return json.decode(response.body);
      } else {
        print('Erro ao obter pedidos de férias: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erro ao obter pedidos de férias: $e');
      return [];
    }
  }

  // Cancelar Pedido de Férias
  Future<bool> cancelarPedidoFerias({
    required String token,
    required String idPedido,
  }) async {
    var url = '/ferias/$idPedido/cancelar'; // Atualize o endpoint conforme necessário
    try {
      var response = await _delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print('Pedido de férias cancelado com sucesso!');
        return true;
      } else {
        print('Erro ao cancelar pedido de férias: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro ao cancelar pedido de férias: $e');
      return false;
    }
  }

  // =========================
  //        Utilizador
  // =========================

  // Obter dados do utilizador
  Future<Map<String, dynamic>?> obterDadosUtilizador() async {
    var url = '/utilizador/dados';
    try {
      String? token = await obterTokenLocalmente();
      if (token == null) {
        print('Token não encontrado. Faça login novamente.');
        return null;
      }
      var response =
          await _get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var dados = json.decode(response.body);
        print('Dados do utilizador: $dados');
        return dados;
      } else {
        print('Erro ao obter dados do utilizador: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao obter dados do utilizador: $e');
      return null;
    }
  }

  // Atualizar a senha do utilizador
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

  // Atualizar dados do utilizador
  Future<void> atualizarDadosUtilizador(
      Map<String, dynamic> novosDados) async {
    var url = '/utilizador/atualizarDados';
    try {
      String? token = await obterTokenLocalmente();
      if (token == null) {
        print('Token não encontrado. Faça login novamente.');
        return;
      }
      var response = await _put(
        url,
        novosDados,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        print('Dados do utilizador atualizados com sucesso!');
      } else {
        print('Erro ao atualizar dados do utilizador: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao atualizar dados do utilizador: $e');
    }
  }

  // =========================
  //   Notícias e Conteúdo
  // =========================

  // Obter notícias
  Future<List<dynamic>> obterNoticias() async {
    var url = '/noticias';
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

  // Obter conteúdo para o slider
  Future<List<dynamic>> obterConteudoSlider() async {
    var url = '/conteudo/slider'; // Assumindo que esse é o endpoint correto
    try {
      var response = await _get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro ao obter conteúdo do slider: ${response.statusCode}');
        throw Exception('Erro ao obter conteúdo do slider');
      }
    } catch (e) {
      print('Erro ao obter conteúdo do slider: $e');
      throw Exception('Erro ao obter conteúdo do slider');
    }
  }

  // =========================
  //        Submissões
  // =========================

  // Obter status das submissões
  Future<List<dynamic>> obterStatusSubmissoes() async {
    var url =
        '/utilizador/status_submissoes'; // Assumindo que esse é o endpoint para os status dos pedidos/submissões
    try {
      String? token = await obterTokenLocalmente();
      if (token == null) {
        print('Token não encontrado. Faça login novamente.');
        return [];
      }
      var response =
          await _get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro ao obter status das submissões: ${response.statusCode}');
        throw Exception('Erro ao obter status das submissões');
      }
    } catch (e) {
      print('Erro ao obter status das submissões: $e');
      throw Exception('Erro ao obter status das submissões');
    }
  }

  // =========================
  //        Enviar Horas
  // =========================

  // Método para enviar pedido de horas
  Future<bool> enviarHoras({
    required String token,
    required String descricao,
    required String horas,
  }) async {
    var url = '/horas'; // Atualize o endpoint conforme necessário
    try {
      var response = await _post(
        url,
        {
          'descricao': descricao,
          'horas': horas,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Horas enviadas com sucesso!');
        return true;
      } else {
        print('Erro ao enviar horas: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro ao enviar horas: $e');
      return false;
    }
  }

  // =========================
  //     Pedido de Reunião
  // =========================

  // Método para enviar um pedido de reunião
  Future<bool> enviarPedidoReuniao({
    required String token,
    required String titulo,
    required String descricao,
    required DateTime dataHora,
    required List<String> participantes,
  }) async {
    var url = '/reunioes/solicitar'; // Atualize o endpoint conforme necessário
    try {
      var response = await _post(
        url,
        {
          'titulo': titulo,
          'descricao': descricao,
          'data_hora': dataHora.toIso8601String(),
          'participantes': participantes,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Pedido de reunião enviado com sucesso!');
        return true;
      } else {
        print('Erro ao enviar pedido de reunião: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro ao enviar pedido de reunião: $e');
      return false;
    }
  }

}
