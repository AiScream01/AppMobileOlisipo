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