import 'dart:convert';
import 'package:http/http.dart' as http;
import 'basedados.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

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

    List<(String, String, String, String, String, String, String, String)>
        utilizador = [];
    List<(String, String, String)> ferias = [];
    List<(String, String, String, String)> ajudas = [];
    List<(String, String, String)> horas = [];
    List<(String, String, String, String)> reunioes = [];
    List<(String, String, String, String, String, String)> despesasViatura = [];
    List<(String, String, String, String)> faltas = [];

    var result = await http.get(Uri.parse(url));

    var listaUtilizador = jsonDecode(result.body)['utilizador'];
    listaUtilizador.forEach((linha) {
      utilizador.add((
        linha['id_user'].toString(),
        linha['nome'].toString(),
        linha['email'].toString(),
        linha['foto'].toString(),
        linha['palavrapasse'].toString(),
        linha['declaracao_academica'].toString(),
        linha['declaracao_bancaria'].toString(),
        linha['role'].toString()
      ));
    });

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
      horas.add((
        linha['horas'].toString(),
        linha['estado'].toString(),
        linha['comprovativo'].toString()
      ));
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
      faltas.add((
        linha['estado'].toString(),
        linha['data'].toString(),
        linha['justificacao'].toString(),
        linha['horas'].toString()
      ));
    });

    var bd = Basededados();

    // Limpa dados antigos
    await bd.limparDados();

    bd.inserirUtilizador(utilizador);
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
    String? path, // O caminho do arquivo PDF
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || custo.isEmpty) {
      throw Exception('Dados inválidos: idUser e custo são obrigatórios.');
    }

    // Define a URL base e o endpoint para inserir as ajudas de custo
    var url = '$baseURL/ajudascusto/create';

    // Cria o cliente HTTP
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['id_user'] = idUser
      ..fields['custo'] = custo
      ..fields['descricao'] = descricao;

    // Adiciona o arquivo, se o caminho não for nulo
    if (path != null && File(path).existsSync()) {
      var file = await http.MultipartFile.fromPath(
        'comprovativo', // O nome do campo de arquivo no formulário
        path,
        contentType:
            MediaType('application', 'pdf'), // Define o tipo MIME do arquivo
      );
      request.files.add(file);
    }

    // Envia a requisição e obtém a resposta
    var response = await request.send();

    // Processa a resposta
    if (response.statusCode == 201) {
      print('Ajuda de custo inserida com sucesso!');
    } else {
      print('Falha ao inserir ajuda de custo: ${response.statusCode}');
    }
  }

Future<void> insertDespesasViaturaPessoal(
  String idUser,
  double km,
  String pontoPartida,
  String pontoChegada,
  double precoPortagens,
  String? path,
) async {
  // Verifica se os parâmetros obrigatórios não estão vazios
  if (idUser.isEmpty || pontoPartida.isEmpty || pontoChegada.isEmpty) {
    throw Exception(
        'Dados inválidos: idUser, pontoPartida e pontoChegada são obrigatórios.');
  }

  var url = '$baseURL/despesasviatura/create';

  // Criar uma requisição multipart
  var request = http.MultipartRequest('POST', Uri.parse(url));
  // Adicionar os campos do formulário
  request.fields['id_user'] = idUser;
  request.fields['km'] = km.toString();
  request.fields['ponto_partida'] = pontoPartida;
  request.fields['ponto_chegada'] = pontoChegada;
  request.fields['preco_portagens'] = precoPortagens.toString();

  // Adicionar o arquivo se ele existir
  if (path != null && File(path).existsSync()) {
      var comprovativoFile = await http.MultipartFile.fromPath(
        'comprovativo',
        path,
        contentType:
            MediaType('application', 'pdf'), // Define o tipo MIME do arquivo
      );
      request.files.add(comprovativoFile);
  }

  var response = await request.send();

  // Processa a resposta
    if (response.statusCode == 201) {
      print('Despesa de viatura pessoal inserida com sucesso!');
    } else {
      print('Falha ao inserir despesa de viatura pessoal: ${response.statusCode}');
    }
}


  Future<void> insertFalta(
    String idUser,
    DateTime data,
    String horas,
    String justificacao,
    String? path,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || justificacao.isEmpty || horas.isEmpty) {
      throw Exception(
          'Dados inválidos: idUser, justificacao e horas são obrigatórios.');
    }

    // Define a URL base e o endpoint para inserir a falta
    var url = '$baseURL/faltas/create';

    // Prepara o corpo da requisição
    var requestBody = {
      'id_user': idUser,
      'data': data.toIso8601String(),
      'horas': horas,
      'justificacao': justificacao,
      'path': path ?? '', // Inclua o caminho do arquivo, se necessário
    };

    // Print dos dados que estão sendo enviados
    print('Enviando dados para o servidor:');
    print('URL: $url');
    print('Dados: ${jsonEncode(requestBody)}');

    // Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
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
    String comprovativo,
    String? path, // O caminho do arquivo PDF
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || horas.isEmpty) {
      throw Exception('Dados inválidos: idUser e horas são obrigatórios.');
    }

    // Define a URL base e o endpoint para inserir as horas
    var url = '$baseURL/horas/create';

    // Cria o cliente HTTP multipart
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['id_user'] = idUser
      ..fields['horas'] = horas;

    // Adiciona o arquivo, se o caminho não for nulo e o arquivo existir
    if (path != null && File(path).existsSync()) {
      var file = await http.MultipartFile.fromPath(
        'comprovativo', // O nome do campo de arquivo no formulário
        path,
        contentType:
            MediaType('application', 'pdf'), // Define o tipo MIME do arquivo
      );
      request.files.add(file);
    }

    // Envia a requisição e obtém a resposta
    var response = await request.send();

    // Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Horas inseridas com sucesso!');
    } else {
      print('Erro ao inserir horas: ${response.statusCode}');
      throw Exception('Falha ao inserir horas: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    // Define a URL do endpoint que lista todos os utilizadores
    var url = '$baseURL/utilizador/';

    // Faz a requisição GET para obter a lista de utilizadores
    var response = await http.get(Uri.parse(url));

    // Verifica o status da resposta
    if (response.statusCode == 200) {
      // Se a resposta for bem-sucedida, decodifica o corpo da resposta
      List<dynamic> data = jsonDecode(response.body);

      // Converte a lista dinâmica em uma lista de mapas (Map<String, dynamic>)
      List<Map<String, dynamic>> users = data.map((user) {
        return Map<String, dynamic>.from(user);
      }).toList();

      return users; // Retorna a lista de utilizadores
    } else {
      // Se houver um erro, lança uma exceção
      throw Exception('Falha ao carregar utilizadores: ${response.statusCode}');
    }
  }

  Future<void> insertReuniao(
    String titulo,
    String descricao,
    String data,
    String hora,
    String idUser,
    String nomeUtilizadorReuniao,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (titulo.isEmpty ||
        descricao.isEmpty ||
        data.isEmpty ||
        hora.isEmpty||
        idUser.isEmpty ||
        nomeUtilizadorReuniao.isEmpty
    ) {
      throw Exception('Dados inválidos: todos os parâmetros são obrigatórios.');
    }

    // Define a URL base e o endpoint para criar a reunião
    var url = '$baseURL/reunioes/create';

// Prepara os dados a serem enviados
    var dadosReuniao = {
      'titulo': titulo,
      'descricao': descricao,
      'data': data,
      'hora': hora,
      'id_user': idUser,
      'nome_utilizador_reuniao': nomeUtilizadorReuniao,
    };

// Imprime os dados para depuração
    print('Dados enviados para o servidor: $dadosReuniao');

// Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dadosReuniao),
    );
// Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Reunião criada com sucesso!');
    } else {
      print('Erro ao criar reunião: ${response.statusCode}');
      throw Exception('Falha ao criar reunião: ${response.body}');
    }
  }

  // Função para inserir um recibo de vencimento
  Future<void> insertReciboVencimento(
    String recibo,
    String idUser,
    String data,
    String hora,
  ) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (recibo.isEmpty || idUser.isEmpty || data.isEmpty || hora.isEmpty) {
      throw Exception('Dados inválidos: todos os parâmetros são obrigatórios.');
    }

    // Define a URL base e o endpoint para criar o recibo de vencimento
    var url = '$baseURL/recibosvencimento/create';

    // Prepara a requisição HTTP POST
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'recibo': recibo,
        'id_user': idUser,
        'data': data,
        'hora': hora,
      }),
    );

    // Imprime o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Verifica o status da resposta
    if (response.statusCode == 201) {
      print('Recibo de vencimento criado com sucesso!');
    } else {
      print('Erro ao criar recibo de vencimento: ${response.statusCode}');
      throw Exception('Falha ao criar recibo de vencimento: ${response.body}');
    }
  }

  Future<void> updateProfile({
    required String idUser,
    required String nome,
    required String email,
    String? fotoPath,
    String? palavrapasse,
    String? declaracaoAcademica,
    String? declaracaoBancaria,
    required String role,
  }) async {
    // Verifica se os parâmetros obrigatórios não estão vazios
    if (idUser.isEmpty || nome.isEmpty || email.isEmpty || role.isEmpty) {
      throw Exception(
          'Dados inválidos: ID, nome, email e role são obrigatórios.');
    }

    // Prepara os dados a serem enviados
    final updateData = <String, dynamic>{
      'nome': nome,
      'email': email,
      'foto': fotoPath != null
          ? fotoPath.split('/').last
          : null, // Obtém o nome do arquivo da foto
      'palavrapasse': palavrapasse != null
          ? await _hashPassword(palavrapasse)
          : null, // Hash da senha se fornecida
      'declaracao_academica': declaracaoAcademica,
      'declaracao_bancaria': declaracaoBancaria,
      'role': role,
    };

    // Remove chaves com valores nulos
    updateData.removeWhere((key, value) => value == null);

    // Define a URL base e o endpoint para atualizar o perfil
    var url =
        '$baseURL/utilizador/update/$idUser'; // Ajuste o endpoint conforme necessário

    // Prepara a requisição HTTP PUT
    var response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updateData),
    );

    // Imprime o status code e o corpo da resposta para depuração
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Verifica o status da resposta
    if (response.statusCode == 200) {
      print('Perfil atualizado com sucesso!');
    } else {
      print('Erro ao atualizar perfil: ${response.statusCode}');
      throw Exception('Falha ao atualizar perfil: ${response.body}');
    }
  }

  // Função fictícia para hash de senha
  Future<String> _hashPassword(String password) async {
    // Aqui você deve adicionar o código para criptografar a senha
    // Em uma aplicação real, você geralmente faz isso no servidor
    return password; // Retorna a senha sem alterações para o exemplo
  }

//LOGIN
  Future<String> login(String email, String palavrapasse) async {
    if (email.isEmpty || palavrapasse.isEmpty) {
      throw Exception('Dados inválidos: username e password são obrigatórios.');
    }

    var url = '$baseURL/utilizador/login';

    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'palavrapasse': palavrapasse,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Verifique o tipo do campo 'id' e ajuste conforme necessário
      var idUser = data['id'];
      if (idUser is int) {
        idUser = idUser.toString(); // Converte int para String
      } else if (idUser is! String) {
        throw Exception('Tipo inesperado para idUser');
      }

      return idUser; // Retorna o idUser como String
    } else {
      throw Exception('Falha ao realizar login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getProfile(String idUser) async {
    // Simulação de uma requisição para obter os dados do perfil
    // Substitua isso com a lógica real de comunicação com o servidor
    final response = await http
        .get(Uri.parse('https://pi4-api.onrender.com/profile/$idUser'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar perfil');
    }
  }
}
