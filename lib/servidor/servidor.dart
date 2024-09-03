import 'dart:convert';
import 'package:http/http.dart' as http;
import 'basedados.dart';

class Servidor {
  final String baseURL = 'https://pi4-api.onrender.com'; // URL base principal
  var url;

  Future<void> getNoticiasEParcerias() async {
    url = '$baseURL/appmobile/noticiasparcerias';

    List<(String, String, String, String)> parcerias = [];
    List<(String, String, String, String)> noticias = [];

    var result = await http.get(Uri.parse(url));

    var lista1 = jsonDecode(result.body)['parcerias'];
    lista1.forEach((linha) {
      parcerias.add((
        linha['logotipo'].toString(),
        linha['titulo'].toString(),
        linha['descricao'].toString(),
        linha['categoria'].toString()
      ));
    });

    var lista2 = jsonDecode(result.body)['noticias'];
    lista2.forEach((linha) {
      noticias.add((
        linha['titulo'].toString(),
        linha['descricao'].toString(),
        linha['data'].toString(),
        linha['imagem'].toString()
      ));
    });

    var bd = Basededados();
    bd.inserirParceria(parcerias);
    bd.inserirNoticia(noticias);
  }

  Future<void> getDadosServidor(String idUser) async {
    url = '$baseURL/appmobile/$idUser';

    List<(String, String, String)> ferias = [];
    List<(String, String, String, String)> ajudas = [];
    List<(String, String)> horas = [];
    List<(String, String, String, String)> reunioes = [];
    List<(String, String, String, String, String, String)> despesasViatura = [];
    List<(String, String)> faltas = [];

    var result = await http.get(Uri.parse(url));

    var listaFerias = jsonDecode(result.body)['ferias'];
    listaFerias.forEach((linha) {
      ferias.add((
        linha['data_inicio'].toString(),
        linha['data_fim'].toString(),
        linha['estado'].toString()
      ));
    });

    var listaAjudas = jsonDecode(result.body)['ajudas'];
    listaAjudas.forEach((linha) {
      ajudas.add((
        linha['custo'].toString(),
        linha['descricao'].toString(),
        linha['comprovativo'].toString(),
        linha['estado'].toString()
      ));
    });

    var listaHoras = jsonDecode(result.body)['horas'];
    listaHoras.forEach((linha) {
      horas.add((linha['horas'].toString(), linha['estado'].toString()));
    });

    var listaReunioes = jsonDecode(result.body)['reunioes'];
    listaReunioes.forEach((linha) {
      reunioes.add((
        linha['titulo'].toString(),
        linha['descricao'].toString(),
        linha['data'].toString(),
        linha['estado'].toString()
      ));
    });

    var listaDespesasViatura = jsonDecode(result.body)['despesasViatura'];
    listaDespesasViatura.forEach((linha) {
      despesasViatura.add((
        linha['ponto_partida'].toString(),
        linha['ponto_chegada'].toString(),
        linha['km'].toString(),
        linha['comprovativo'].toString(),
        linha['preco_portagens'].toString(),
        linha['estado'].toString(),
      ));
    });

    var listaFaltas = jsonDecode(result.body)['faltas'];
    listaFaltas.forEach((linha) {
      faltas.add((linha['estado'].toString(), linha['data'].toString()));
    });

    var bd = Basededados();
    bd.inserirFerias(ferias);
    bd.inserirAjudaCusto(ajudas);
    bd.inserirHoras(horas);
    bd.inserirReuniao(reunioes);
    bd.inserirDespesaViaturaPessoal(despesasViatura);
    bd.inserirFalta(faltas);
  }

  Future<void> insertFerias(
      String idUser, String dataInicio, String dataFim, String estado) async {
    if (idUser.isEmpty ||
        dataInicio.isEmpty ||
        dataFim.isEmpty ||
        estado.isEmpty) {
      throw Exception(
          'Dados inválidos: um ou mais parâmetros são nulos ou vazios.');
    }

    var url = '$baseURL/ferias/create';

    // Converta as datas para o formato ISO 8601
    var dataInicioIso = DateTime.parse(dataInicio).toIso8601String();
    var dataFimIso = DateTime.parse(dataFim).toIso8601String();

    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'data_inicio': dataInicioIso,
        'data_fim': dataFimIso,
        'id_user': idUser
      }),
    );

    // Imprima o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      print('Férias inseridas com sucesso!');
    } else {
      print('Erro ao inserir férias: ${response.statusCode}');
      throw Exception('Falha ao inserir férias: ${response.body}');
    }
  }

  Future<void> insertAjudasCusto(
    String idUser,
    String custo,
    String descricao,
    String comprovativo,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || custo.isEmpty) {
      throw Exception('Dados inválidos: idUser e custo são obrigatórios.');
    }

    // Define a URL base e o endpoint para inserir as ajudas de custo
    var url = '$baseURL/ajudascusto/create';

    // Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'custo': custo,
        'descricao': descricao,
        'comprovativo': comprovativo,
        'id_user': idUser,
      }),
    );

    // Imprime o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Ajuda de custo inserida com sucesso!');
    } else {
      print('Erro ao inserir ajuda de custo: ${response.statusCode}');
      throw Exception('Falha ao inserir ajuda de custo: ${response.body}');
    }
  }

  Future<void> insertDespesasViaturaPessoal(
    String idUser,
    double km,
    String pontoPartida,
    String pontoChegada,
    double precoPortagens,
    String comprovativo,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || pontoPartida.isEmpty || pontoChegada.isEmpty) {
      throw Exception(
          'Dados inválidos: idUser, pontoPartida e pontoChegada são obrigatórios.');
    }

    // Define a URL base e o endpoint para inserir as despesas de viatura pessoal
    var url = '$baseURL/despesasviatura/create';

    // Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'km': km,
        'ponto_partida': pontoPartida,
        'ponto_chegada': pontoChegada,
        'preco_portagens': precoPortagens,
        'comprovativo': comprovativo,
        'id_user': idUser,
      }),
    );

    // Imprime o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Despesa de viatura pessoal inserida com sucesso!');
    } else {
      print(
          'Erro ao inserir despesa de viatura pessoal: ${response.statusCode}');
      throw Exception(
          'Falha ao inserir despesa de viatura pessoal: ${response.body}');
    }
  }

  Future<void> insertFalta(
    String idUser,
    DateTime data,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || data == null) {
      throw Exception('Dados inválidos: idUser e data são obrigatórios.');
    }

    // Define a URL base e o endpoint para inserir a falta
    var url = '$baseURL/faltas/create';

    // Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_user': idUser,
        'data': data.toIso8601String(),
      }),
    );

    // Imprime o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Falta inserida com sucesso!');
    } else {
      print('Erro ao inserir falta: ${response.statusCode}');
      throw Exception('Falha ao inserir falta: ${response.body}');
    }
  }

  Future<void> insertHoras(
    String idUser,
    String horas,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || horas.isEmpty) {
      throw Exception('Dados inválidos: idUser e horas são obrigatórios.');
    }

    // Define a URL base e o endpoint para inserir as horas
    var url = '$baseURL/horas/create';

    // Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_user': idUser,
        'horas': horas,
      }),
    );

    // Imprime o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Horas inseridas com sucesso!');
    } else {
      print('Erro ao inserir horas: ${response.statusCode}');
      throw Exception('Falha ao inserir horas: ${response.body}');
    }
  }

  Future<void> insertReuniao(
    String titulo,
    String descricao,
    String data,
    String idUser,
    String nomeUtilizadorReuniao,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (titulo.isEmpty ||
        descricao.isEmpty ||
        data.isEmpty ||
        idUser.isEmpty ||
        nomeUtilizadorReuniao.isEmpty) {
      throw Exception('Dados inválidos: todos os parâmetros são obrigatórios.');
    }

    // Define a URL base e o endpoint para criar a reunião
    var url = '$baseURL/reunioes/create';

    // Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'titulo': titulo,
        'descricao': descricao,
        'data': data,
        'id_user': idUser,
        'nome_utilizador_reuniao': nomeUtilizadorReuniao, // Corrigido
      }),
    );

    // Imprime o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Reunião criada com sucesso!');
    } else {
      print('Erro ao criar reunião: ${response.statusCode}');
      throw Exception('Falha ao criar reunião: ${response.body}');
    }
  }

//LOGIN
  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Dados inválidos: username e password são obrigatórios.');
    }

    var url = '$baseURL/utilizador/login';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Login bem-sucedido: ${data}');
      } else {
        print('Erro ao realizar login: ${response.statusCode}');
        throw Exception('Falha ao realizar login: ${response.body}');
      }
    } catch (e) {
      print('Erro ao realizar login: $e');
    }
  }
}







// =========================
  //     AQUI PARA BAIXO
  // =========================// =========================
  //     AQUI PARA BAIXO
  // =========================// =========================
  //     AQUI PARA BAIXO
  // =========================// =========================
  //     AQUI PARA BAIXO
  // =========================// =========================
  //    AQUI PARA BAIXO
  // =========================// =========================
  //     AQUI PARA BAIXO
  // =========================// =========================
  //     AQUI PARA BAIXO
  // =========================
  // =========================
  //     Métodos HTTP Básicos
  // =========================

  //// Método para requisições GET
  //Future<http.Response> _get(String endpoint,
  //    {Map<String, String>? headers}) async {
  //  try {
  //    final response =
  //        await http.get(Uri.parse('$baseURL$endpoint'), headers: headers);
  //    return response;
  //  } catch (e) {
  //    print('Erro na requisição GET: $e');
  //    throw Exception('Erro na requisição GET');
  //  }
  //}
//
  //// Método para requisições POST
  //Future<http.Response> _post(String endpoint, Map<String, dynamic> body,
  //    {Map<String, String>? headers}) async {
  //  try {
  //    final response = await http.post(
  //      Uri.parse('$baseURL$endpoint'),
  //      headers: headers,
  //      body: jsonEncode(body),
  //    );
  //    return response;
  //  } catch (e) {
  //    print('Erro na requisição POST: $e');
  //    throw Exception('Erro na requisição POST');
  //  }
  //}
//
  //// Método para requisições PUT
  //Future<http.Response> _put(String endpoint, Map<String, dynamic> body,
  //    {Map<String, String>? headers}) async {
  //  try {
  //    final response = await http.put(
  //      Uri.parse('$baseURL$endpoint'),
  //      headers: headers,
  //      body: jsonEncode(body),
  //    );
  //    return response;
  //  } catch (e) {
  //    print('Erro na requisição PUT: $e');
  //    throw Exception('Erro na requisição PUT');
  //  }
  //}
//
  //// Método para requisições DELETE
  //Future<http.Response> _delete(String endpoint,
  //    {Map<String, String>? headers}) async {
  //  try {
  //    final response =
  //        await http.delete(Uri.parse('$baseURL$endpoint'), headers: headers);
  //    return response;
  //  } catch (e) {
  //    print('Erro na requisição DELETE: $e');
  //    throw Exception('Erro na requisição DELETE');
  //  }
  //}
//
  //// =========================
  ////    Autenticação e Tokens
  //// =========================
//
  //// Método para login
  //Future<String?> login(String email, String password) async {
  //  var url = '/utilizador/login';
  //  try {
  //    var response =
  //        await _post(url, {'email_param': email, 'pass_param': password});
  //    if (response.statusCode == 200) {
  //      Map<String, dynamic> responseBody = json.decode(response.body);
  //      String? token = responseBody['token'];
  //      if (token != null) {
  //        await saveToken(token);
  //      }
  //      return token;
  //    } else {
  //      print('Erro no login: ${response.statusCode}');
  //      return null;
  //    }
  //  } catch (e) {
  //    print('Erro ao fazer login: $e');
  //    return null;
  //  }
  //}
//
  //// Método para salvar o token localmente
  //Future<void> saveToken(String token) async {
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //  await prefs.setString('token', token);
  //}
//
  //// Método para obter o token localmente
  //Future<String?> obterTokenLocalmente() async {
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //  return prefs.getString('token');
  //}
//
  //// Método para remover o token
  //Future<void> removeToken() async {
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //  await prefs.remove('token');
  //}
//
  //// =========================
  ////    Recuperação de Senha
  //// =========================
//
//// Método para iniciar recuperação de senha
  //Future<bool> recuperarSenha(String email) async {
  //  var url = '/utilizador/recuperarSenha'; // Substitua pelo endpoint real
  //  try {
  //    var response = await _post(
  //      url,
  //      {'email_param': email},
  //      headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //    );
  //    if (response.statusCode == 200) {
  //      print('Solicitação de recuperação de senha enviada com sucesso!');
  //      return true;
  //    } else {
  //      print(
  //          'Erro ao enviar solicitação de recuperação de senha: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao enviar solicitação de recuperação de senha: $e');
  //    return false;
  //  }
  //}
//
  //// Solicitar token de redefinição de senha
  //Future<bool> solicitarTokenRedefinicaoSenha(String email) async {
  //  var url = '/utilizador/solicitarTokenRedefinicaoSenha';
  //  try {
  //    var response = await _post(
  //      url,
  //      {'email': email},
  //      headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //    );
  //    if (response.statusCode == 200) {
  //      print('Token de redefinição de senha solicitado com sucesso!');
  //      return true;
  //    } else {
  //      print(
  //          'Erro ao solicitar token de redefinição de senha: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao solicitar token de redefinição de senha: $e');
  //    return false;
  //  }
  //}
//
  //// Confirmar nova senha com o token
  //Future<bool> confirmarNovaSenha({
  //  required String token,
  //  required String novaSenha,
  //}) async {
  //  var url = '/utilizador/confirmarNovaSenha';
  //  try {
  //    var response = await _post(
  //      url,
  //      {
  //        'token': token,
  //        'nova_senha': novaSenha,
  //      },
  //      headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //    );
  //    if (response.statusCode == 200) {
  //      print('Senha redefinida com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao redefinir senha: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao redefinir senha: $e');
  //    return false;
  //  }
  //}
//
  //// =========================
  ////         Parcerias
  //// =========================
//
  //// Obter lista de parcerias
  //Future<List<dynamic>> obterParcerias() async {
  //  var url = '/protocolosparceria'; //Corrigido
  //  try {
  //    var response = await _get(url);
  //    if (response.statusCode == 200) {
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter lista de parcerias: ${response.statusCode}');
  //      return [];
  //    }
  //  } catch (e) {
  //    print('Erro ao obter lista de parcerias: $e');
  //    return [];
  //  }
  //}
//
  //// Obter detalhes de uma parceria específica
  //Future<Map<String, dynamic>?> obterDetalhesParceria(String idParceria) async {
  //  var url = '/protocolosparceria/$idParceria'; //Corrigido
  //  try {
  //    var response = await _get(url);
  //    if (response.statusCode == 200) {
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter detalhes da parceria: ${response.statusCode}');
  //      return null;
  //    }
  //  } catch (e) {
  //    print('Erro ao obter detalhes da parceria: $e');
  //    return null;
  //  }
  //}
//
  //// =========================
  ////     Ajudas de Custo
  //// =========================
//
  ////Inserir Ajudas de Custo
  //Future<void> inserirAjudaCusto(String? token, double valorAjuda,
  //    String descritivoAjuda, String faturaAjuda) async {
  //  var url = '/ajudascusto/'; // Corrigido
  //  try {
  //    var response = await _post(
  //      url,
  //      {
  //        'custo_param': valorAjuda,
  //        'descricao_param': descritivoAjuda,
  //        'comprovativo_param': faturaAjuda,
  //      },
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8'
  //      },
  //    );
  //    if (response.statusCode == 200) {
  //      print('Ajudas de Custo inseridas com sucesso!');
  //    } else {
  //      print('Erro ao inserir Ajudas de Custo: ${response.statusCode}');
  //      throw Exception('Falha ao inserir Ajudas de Custo');
  //    }
  //  } catch (e) {
  //    print('Erro ao inserir Ajuda de Custo: $e');
  //  }
  //}
//
  //// =========================
  ////    Despesas de Viatura
  //// =========================
//
  //// Enviar despesas de viatura
  //Future<bool> enviarDespesasViatura({
  //  required String token,
  //  required String partida,
  //  required String chegada,
  //  required double quilometros,
  //  required double portagens,
  //  String? comprovativoPath,
  //}) async {
  //  try {
  //    // URL corrigido para apontar para a rota correta
  //    var uri = Uri.parse('$baseURL/despesas_viatura/create');
  //    var request = http.MultipartRequest('POST', uri);
//
  //    request.headers['Authorization'] = 'Bearer $token';
//
  //    request.fields['partida'] = partida;
  //    request.fields['chegada'] = chegada;
  //    request.fields['quilometros'] = quilometros.toString();
  //    request.fields['portagens'] = portagens.toString();
//
  //    if (comprovativoPath != null) {
  //      request.files.add(await http.MultipartFile.fromPath(
  //        'comprovativo',
  //        comprovativoPath,
  //      ));
  //    }
//
  //    var response = await request.send();
//
  //    if (response.statusCode == 200 || response.statusCode == 201) {
  //      print('Despesas de viatura enviadas com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao enviar despesas de viatura: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print("Erro ao enviar despesas de viatura: $e");
  //    return false;
  //  }
  //}
//
  //// =========================
  ////          Faltas
  //// =========================
//
  ////Enviar faltas
  //Future<bool> enviarFalta({
  //  required String token,
  //  required String data,
  //  required String descricao,
  //  String? comprovativoPath,
  //}) async {
  //  try {
  //    // Atualize o URL para corresponder ao backend
  //    var uri = Uri.parse('$baseURL/faltas/create'); // Corrigido
  //    var request = http.MultipartRequest('POST', uri);
//
  //    request.headers['Authorization'] = 'Bearer $token';
//
  //    request.fields['data'] = data;
  //    request.fields['descricao'] = descricao;
//
  //    if (comprovativoPath != null) {
  //      request.files.add(await http.MultipartFile.fromPath(
  //        'comprovativo',
  //        comprovativoPath,
  //      ));
  //    }
//
  //    var response = await request.send();
//
  //    if (response.statusCode == 200 || response.statusCode == 201) {
  //      print('Falta enviada com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao enviar falta: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print("Erro ao enviar falta: $e");
  //    return false;
  //  }
  //}
//
  //// =========================
////          Férias
//// =========================
//
//// Enviar Pedido de Férias
  //Future<bool> enviarPedidoFerias({
  //  required DateTime dataInicio,
  //  required DateTime dataFim,
  //}) async {
  //  var url = '$baseURL/ferias/create'; // Atualizado para o endpoint correto
  //  try {
  //    var response = await _post(
  //      url,
  //      {
  //        'data_inicio': dataInicio.toIso8601String(),
  //        'data_fim': dataFim.toIso8601String(),
  //      },
  //      headers: {
  //        'Content-Type': 'application/json; charset=UTF-8',
  //      },
  //    );
  //    if (response.statusCode == 201) {
  //      print('Pedido de férias enviado com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao enviar pedido de férias: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao enviar pedido de férias: $e');
  //    return false;
  //  }
  //}
//
  //// Obter Pedidos de Férias
  //Future<List<dynamic>> obterPedidosFerias({required String token}) async {
  //  var url = '/ferias'; // Atualize o endpoint conforme necessário
  //  try {
  //    var response = await _get(
  //      url,
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8',
  //      },
  //    );
  //    if (response.statusCode == 200) {
  //      print('Pedidos de férias obtidos com sucesso!');
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter pedidos de férias: ${response.statusCode}');
  //      return [];
  //    }
  //  } catch (e) {
  //    print('Erro ao obter pedidos de férias: $e');
  //    return [];
  //  }
  //}
//
  //// Cancelar Pedido de Férias
  //Future<bool> cancelarPedidoFerias({
  //  required String token,
  //  required String idPedido,
  //}) async {
  //  var url =
  //      '/ferias/$idPedido/cancelar'; // Atualize o endpoint conforme necessário
  //  try {
  //    var response = await _delete(
  //      url,
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8',
  //      },
  //    );
  //    if (response.statusCode == 200) {
  //      print('Pedido de férias cancelado com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao cancelar pedido de férias: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao cancelar pedido de férias: $e');
  //    return false;
  //  }
  //}
//
  //// =========================
  ////        Utilizador
  //// =========================
//
//// Método para registrar um novo utilizador
  //Future<bool> registrarUtilizador({
  //  required String nomeCompleto,
  //  required String email,
  //}) async {
  //  var url = '/utilizador/create'; // URL corrigida
  //  try {
  //    var response = await _post(
  //      url,
  //      {
  //        'nome_completo': nomeCompleto,
  //        'email': email,
  //      },
  //      headers: {
  //        'Content-Type': 'application/json; charset=UTF-8',
  //      },
  //    );
  //    if (response.statusCode == 201) {
  //      print('Utilizador registrado com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao registrar utilizador: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao enviar registro: $e');
  //    return false;
  //  }
  //}
//
  //// Obter dados do utilizador
  //Future<Map<String, dynamic>?> obterDadosUtilizador(String id) async {
  //  // Adicionado parâmetro 'id'
  //  var url = '/utilizador/$id'; // URL corrigida para usar o ID do utilizador
  //  try {
  //    String? token = await obterTokenLocalmente();
  //    if (token == null) {
  //      print('Token não encontrado. Faça login novamente.');
  //      return null;
  //    }
  //    var response =
  //        await _get(url, headers: {'Authorization': 'Bearer $token'});
  //    if (response.statusCode == 200) {
  //      var dados = json.decode(response.body);
  //      print('Dados do utilizador: $dados');
  //      return dados;
  //    } else {
  //      print('Erro ao obter dados do utilizador: ${response.statusCode}');
  //      return null;
  //    }
  //  } catch (e) {
  //    print('Erro ao obter dados do utilizador: $e');
  //    return null;
  //  }
  //}
//
  //// Atualizar a senha do utilizador
  //Future<void> atualizarSenha(String id, String novaSenha) async {
  //  // Adicionado parâmetro 'id'
  //  var url = '/utilizador/update/$id'; // URL corrigida
  //  try {
  //    String? token = await obterTokenLocalmente();
  //    if (token == null) {
  //      print('Token não encontrado. Faça login novamente.');
  //      return;
  //    }
  //    var response = await _put(
  //      url,
  //      {'senha_param': novaSenha},
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8'
  //      },
  //    );
  //    if (response.statusCode == 200) {
  //      print('Senha atualizada com sucesso!');
  //    } else {
  //      print('Erro ao atualizar senha: ${response.statusCode}');
  //    }
  //  } catch (e) {
  //    print('Erro ao atualizar senha: $e');
  //  }
  //}
//
  //// Atualizar dados do utilizador
  //Future<void> atualizarDadosUtilizador(
  //    String id, Map<String, dynamic> novosDados) async {
  //  // Adicionado parâmetro 'id'
  //  var url = '/utilizador/update/$id'; // URL corrigida
  //  try {
  //    String? token = await obterTokenLocalmente();
  //    if (token == null) {
  //      print('Token não encontrado. Faça login novamente.');
  //      return;
  //    }
  //    var response = await _put(
  //      url,
  //      novosDados,
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8'
  //      },
  //    );
  //    if (response.statusCode == 200) {
  //      print('Dados do utilizador atualizados com sucesso!');
  //    } else {
  //      print('Erro ao atualizar dados do utilizador: ${response.statusCode}');
  //    }
  //  } catch (e) {
  //    print('Erro ao atualizar dados do utilizador: $e');
  //  }
  //}
//
  //// =========================
  ////   Notícias e Conteúdo
  //// =========================
//
  //// Obter notícias
  //Future<List<dynamic>> obterNoticias() async {
  //  var url = '/noticias'; // URL está correta
  //  try {
  //    var response = await _get(url);
  //    if (response.statusCode == 200) {
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter notícias: ${response.statusCode}');
  //      throw Exception('Erro ao obter notícias');
  //    }
  //  } catch (e) {
  //    print('Erro ao obter notícias: $e');
  //    throw Exception('Erro ao obter notícias');
  //  }
  //}
//
  //// Obter conteúdo para o slider
  //Future<List<dynamic>> obterConteudoSlider() async {
  //  var url =
  //      '/conteudo/slider'; // Verifique se este endpoint realmente existe no servidor
  //  try {
  //    var response = await _get(url);
  //    if (response.statusCode == 200) {
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter conteúdo do slider: ${response.statusCode}');
  //      throw Exception('Erro ao obter conteúdo do slider');
  //    }
  //  } catch (e) {
  //    print('Erro ao obter conteúdo do slider: $e');
  //    throw Exception('Erro ao obter conteúdo do slider');
  //  }
  //}
//
  //// =========================
  ////        Submissões
  //// =========================
//
  //// Obter status das submissões
  //Future<List<dynamic>> obterStatusSubmissoes() async {
  //  var url =
  //      '/utilizador/status_submissoes'; // Assumindo que esse é o endpoint para os status dos pedidos/submissões
  //  try {
  //    String? token = await obterTokenLocalmente();
  //    if (token == null) {
  //      print('Token não encontrado. Faça login novamente.');
  //      return [];
  //    }
  //    var response =
  //        await _get(url, headers: {'Authorization': 'Bearer $token'});
  //    if (response.statusCode == 200) {
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter status das submissões: ${response.statusCode}');
  //      throw Exception('Erro ao obter status das submissões');
  //    }
  //  } catch (e) {
  //    print('Erro ao obter status das submissões: $e');
  //    throw Exception('Erro ao obter status das submissões');
  //  }
  //}
//
  //// =========================
  ////        Enviar Horas
  //// =========================
//
  //// Método para enviar pedido de horas
  //Future<bool> enviarHoras({
  //  required String token,
  //  required String descricao,
  //  required String horas,
  //}) async {
  //  var url = '/horas/create'; // Corrigido para o endpoint correto
  //  try {
  //    var response = await _post(
  //      url,
  //      {
  //        'descricao': descricao,
  //        'horas': horas,
  //      },
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8',
  //      },
  //    );
  //    if (response.statusCode == 200 || response.statusCode == 201) {
  //      print('Horas enviadas com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao enviar horas: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao enviar horas: $e');
  //    return false;
  //  }
  //}
//
  //// =========================
  ////     Pedido de Reunião
  //// =========================
//
  //// Método para enviar um pedido de reunião
  //Future<bool> enviarPedidoReuniao({
  //  required String token,
  //  required String titulo,
  //  required String descricao,
  //  required DateTime dataHora,
  //  required List<String> participantes,
  //}) async {
  //  var url = '/reunioes/solicitar'; // Atualize o endpoint conforme necessário
  //  try {
  //    var response = await _post(
  //      url,
  //      {
  //        'titulo': titulo,
  //        'descricao': descricao,
  //        'data_hora': dataHora.toIso8601String(),
  //        'participantes': participantes,
  //      },
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8',
  //      },
  //    );
  //    if (response.statusCode == 200 || response.statusCode == 201) {
  //      print('Pedido de reunião enviado com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao enviar pedido de reunião: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao enviar pedido de reunião: $e');
  //    return false;
  //  }
  //}
//
  //Future<List<dynamic>> obterReunioes({String? token}) async {
  //  var url = '/reunioes';
  //  try {
  //    var response =
  //        await _get(url, headers: {'Authorization': 'Bearer $token'});
  //    if (response.statusCode == 200) {
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter lista de reuniões: ${response.statusCode}');
  //      return [];
  //    }
  //  } catch (e) {
  //    print('Erro ao obter lista de reuniões: $e');
  //    return [];
  //  }
  //}
//
  //Future<Map<String, dynamic>?> obterDetalhesReuniao(String idReuniao,
  //    {String? token}) async {
  //  var url = '/reunioes/$idReuniao';
  //  try {
  //    var response =
  //        await _get(url, headers: {'Authorization': 'Bearer $token'});
  //    if (response.statusCode == 200) {
  //      return json.decode(response.body);
  //    } else {
  //      print('Erro ao obter detalhes da reunião: ${response.statusCode}');
  //      return null;
  //    }
  //  } catch (e) {
  //    print('Erro ao obter detalhes da reunião: $e');
  //    return null;
  //  }
  //}
//
  //Future<bool> marcarReuniao({
  //  required String token,
  //  required String titulo,
  //  required String descricao,
  //  required String dataHora,
  //  required List<String> participantes,
  //}) async {
  //  var url = '/reunioes';
  //  try {
  //    var response = await _post(
  //      url,
  //      {
  //        'titulo': titulo,
  //        'descricao': descricao,
  //        'data_hora': dataHora,
  //        'participantes': participantes,
  //      },
  //      headers: {
  //        'Authorization': 'Bearer $token',
  //        'Content-Type': 'application/json; charset=UTF-8'
  //      },
  //    );
  //    if (response.statusCode == 201) {
  //      print('Reunião marcada com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao marcar reunião: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao marcar reunião: $e');
  //    return false;
  //  }
  //}
//
  //Future<bool> cancelarReuniao(String idReuniao, {String? token}) async {
  //  var url = '/reunioes/$idReuniao';
  //  try {
  //    var response =
  //        await _delete(url, headers: {'Authorization': 'Bearer $token'});
  //    if (response.statusCode == 204) {
  //      print('Reunião cancelada com sucesso!');
  //      return true;
  //    } else {
  //      print('Erro ao cancelar reunião: ${response.statusCode}');
  //      return false;
  //    }
  //  } catch (e) {
  //    print('Erro ao cancelar reunião: $e');
  //    return false;
  //  }
  //}