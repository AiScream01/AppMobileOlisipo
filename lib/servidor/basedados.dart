import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Basededados {
  static const nomebd = "bdadm.db";
  final int versao = 1;
  static Database? _basededados;

  //---------------------------------------
  Future<Database> get basededados async {
    if (_basededados != null) return _basededados!;
    _basededados = await _initDatabase();
    return _basededados!;
  }

  //---------------------------------------
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), nomebd);
    return await openDatabase(
      path,
      version: versao,
      onCreate: _onCreate,
    );
  }

  //---------------------------------------
  Future _onCreate(Database db, int version) async {}

  //---------------------------------------UTILIZADORES-----------------------------------------

  //---------------------------------------Criar tabela de utilizadores
  Future<void> criatabelaUtilizadores() async {
    Database db = await basededados;
    await db.execute('''
      CREATE TABLE utilizadores (
        id_user INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        foto TEXT,
        palavrapasse TEXT,
        declaracao_academica TEXT,
        declaracao_bancaria TEXT,
        role TEXT
      )
    ''');
  }

  //---------------------------------------Inserir utilizador
  Future<void> inserirUtilizador(
      String nome, String email, String palavrapasse) async {
    Database db = await basededados;
    await db.insert(
      'utilizadores',
      {
        'nome': nome,
        'email': email,
        'palavrapasse': palavrapasse,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //---------------------------------------Atualizar utilizador
  Future<void> atualizarUtilizador(
      int id, String nome, String email, String palavrapasse) async {
    Database db = await basededados;
    await db.update(
      'utilizadores',
      {
        'nome': nome,
        'email': email,
        'palavrapasse': palavrapasse,
      },
      where: 'id_user = ?',
      whereArgs: [id],
    );
  }

  //---------------------------------------Excluir utilizador
  Future<void> excluirUtilizador(int id) async {
    Database db = await basededados;
    await db.delete(
      'utilizadores',
      where: 'id_user = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> listarTodosUtilizadores() async {
    Database db = await basededados;
    return await db.query('utilizadores');
  }
  //---------------------------------------FÉRIAS-----------------------------------------

//---------------------------------------Criar tabela de férias
  Future<void> criatabelaFerias(Database db) async {
    await db.execute('DROP TABLE IF EXISTS ferias');
    await db.execute('''
    CREATE TABLE ferias (
      id_ferias INTEGER PRIMARY KEY AUTOINCREMENT,
      data_inicio TEXT,
      data_fim TEXT
    )
    ''');
  }

//---------------------------------------Inserir férias
  Future<void> inserirFerias(List<(String, String)> feriasData) async {
    Database db = await basededados;
    await db.delete('ferias');
    for (final (data_inicio, data_fim) in feriasData) {
      await db.rawInsert(
        'insert into ferias(data_inicio, data_fim) values(?,?)',
        [data_inicio, data_fim],
      );
    }
  }

//---------------------------------------Listar todas as férias
  Future<List<Map<String, dynamic>>> listarTodasFerias() async {
    Database db = await basededados;
    return await db.query('ferias');
  }

////---------------------------------------Listar férias pelo id
//  Future<Map<String, dynamic>?> listarFeriasPorId(int id) async {
//    Database db = await basededados;
//    List<Map<String, dynamic>> resultados = await db.query(
//      'ferias',
//      where: 'id_ferias = ?',
//      whereArgs: [id],
//    );//
//    if (resultados.isNotEmpty) {
//      return resultados
//          .first; // Retorna o primeiro (e único) registro encontrado
//    } else {
//      return null; // Retorna null se nenhum registro for encontrado
//    }
//  }//
//  Future<bool> enviarPedidoFeriasParaServidor({
//    required DateTime dataInicio,
//    required DateTime dataFim,
//    required int idUser,
//  }) async {
//    final url = Uri.parse(
//        'https://seuservidor.com/api/ferias'); // Substitua pela URL real do seu servidor//
//    // Faz a requisição POST
//    final response = await http.post(
//      url,
//      headers: {
//        'Content-Type':
//            'application/json', // Define o tipo de conteúdo como JSON
//      },
//      body: jsonEncode({
//        'data_inicio': dataInicio.toIso8601String(),
//        'data_fim': dataFim.toIso8601String(),
//        'id_user': idUser,
//      }),
//    );//
//    if (response.statusCode == 200) {
//      // Se o servidor retornar status 200, significa que a operação foi bem-sucedida
//      return true;
//    } else {
//      // Caso contrário, exibe o erro no console
//      print('Erro ao enviar dados para o servidor: ${response.statusCode}');
//      return false;
//    }
//  }

  //---------------------------------------PARCERIAS-----------------------------------------

  //---------------------------------------Criar tabela de parcerias
  Future<void> criatabelaParcerias() async {
    Database db = await basededados;
    await db.execute('''
    CREATE TABLE protocolos_parcerias (
      id_parceria INTEGER PRIMARY KEY AUTOINCREMENT,
      logotipo TEXT,
      titulo TEXT,
      descricao TEXT,
      categoria TEXT
    )
  ''');
  }

//---------------------------------------Inserir parceria
  Future<void> inserirParceria(
      List<(String, String, String, String)> parceriaData) async {
    Database db = await basededados;

    await db.delete('protocolos_parcerias');

    for (final (
          logotipo,
          titulo,
          descricao,
          categoria,
        ) in parceriaData) {
      await db.rawInsert(
          ' INSERT INTO protocolos_parcerias (logotipo, titulo,descricao,categoria) VALUES (?,?,?,?)',
          [logotipo, titulo, descricao, categoria]);
      print(titulo);
    }
  }

//---------------------------------------Atualizar parceria
  Future<void> atualizarParceria(
      String idParceria, Map<String, dynamic> parceria) async {
    Database db = await basededados;
    await db.update(
      'protocolos_parcerias',
      parceria,
      where: 'idParceria = ?',
      whereArgs: [idParceria],
    );
  }

//---------------------------------------Listar todas as parcerias
  Future<List<Map<String, dynamic>>> listarTodasParcerias() async {
    Database db = await basededados;
    return await db.query('protocolos_parcerias');
  }

//---------------------------------------Listar parceria por id
  Future<Map<String, dynamic>?> listarParceriaPorId(String idParceria) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'protocolos_parcerias',
      where: 'id_parceria = ?',
      whereArgs: [idParceria],
    );

    if (resultados.isNotEmpty) {
      return resultados.first;
    } else {
      return null;
    }
  }

//---------------------------------------Excluir parceria
  Future<void> excluirParceria(String idParceria) async {
    Database db = await basededados;
    await db.delete(
      'protocolos_parcerias',
      where: 'id_parceria = ?',
      whereArgs: [idParceria],
    );
  }

//---------------------------------------NOTICIAS-----------------------------------------

//---------------------------------------Criar tabela de notícias
  Future<void> criarTabelaNoticias() async {
    Database db = await basededados;
    await db.execute('''
    CREATE TABLE noticias (
      id_noticia INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT,
      descricao TEXT,
      data TEXT,
      imagem TEXT
    )
  ''');
  }

//---------------------------------------Inserir notícia
  Future<void> inserirNoticia(
      List<(String, String, String, String)> noticiaData) async {
    Database db = await basededados;

    await db.delete('noticias');

    for (final (
          titulo,
          descricao,
          data,
          imagem,
        ) in noticiaData) {
      await db.rawInsert(
          ' INSERT INTO noticias (titulo, descricao,data,imagem) VALUES (?,?,?,?)',
          [titulo, descricao, data, imagem]);
      print(titulo);
    }
  }

//---------------------------------------Atualizar notícia
  Future<void> atualizarNoticia(
      String idNoticia, Map<String, dynamic> noticia) async {
    Database db = await basededados;
    await db.update(
      'noticias',
      noticia,
      where: 'id_noticia = ?',
      whereArgs: [idNoticia],
    );
  }

//---------------------------------------Listar todas as notícias
  Future<List<Map<String, dynamic>>> listarTodasNoticias() async {
    Database db = await basededados;
    return await db.query('noticias');
  }

//---------------------------------------Listar notícia por id
  Future<Map<String, dynamic>?> listarNoticiaPorId(String idNoticia) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'noticias',
      where: 'id_noticia = ?',
      whereArgs: [idNoticia],
    );

    if (resultados.isNotEmpty) {
      return resultados.first;
    } else {
      return null;
    }
  }

//---------------------------------------Excluir notícia
  Future<void> excluirNoticia(String idNoticia) async {
    Database db = await basededados;
    await db.delete(
      'noticias',
      where: 'id_noticia = ?',
      whereArgs: [idNoticia],
    );
  }

//---------------------------------------AJUDAS CUSTO-----------------------------------------

//---------------------------------------Criar tabela de ajudas_custo
  Future<void> criarTabelaAjudasCusto(Database db) async {
    await db.execute('''
    CREATE TABLE ajudas_custo (
      id_custo INTEGER PRIMARY KEY AUTOINCREMENT,
      custo REAL,
      descricao TEXT,
      comprovativo TEXT,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
  }

//---------------------------------------Inserir ajuda de custo
  Future<void> inserirAjudaCusto(
      List<(String, String, String)> ajudasData) async {
    Database db = await basededados;
    await db.delete('ajudas_custo');
    for (final (custo, descricao, estado) in ajudasData) {
      await db.rawInsert(
          'insert into ajudas_custo(custo, descricao, estado) values(?,?,?)',
          [custo, descricao, estado]);
    }
  }

//---------------------------------------Atualizar ajuda de custo
  Future<void> atualizarAjudaCusto(
      String idCusto, Map<String, dynamic> ajudaCusto) async {
    Database db = await basededados;
    await db.update(
      'ajudas_custo',
      ajudaCusto,
      where: 'id_custo = ?',
      whereArgs: [idCusto],
    );
  }

//---------------------------------------Listar todas as ajudas de custo
  Future<List<Map<String, dynamic>>> listarTodasAjudasCusto() async {
    Database db = await basededados;
    return await db.query('ajudas_custo');
  }

//---------------------------------------Listar ajuda de custo por id
  Future<Map<String, dynamic>?> listarAjudaCustoPorId(String idCusto) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'ajudas_custo',
      where: 'id_custo = ?',
      whereArgs: [idCusto],
    );

    if (resultados.isNotEmpty) {
      return resultados.first;
    } else {
      return null;
    }
  }

//---------------------------------------Excluir ajuda de custo
  Future<void> excluirAjudaCusto(String idCusto) async {
    Database db = await basededados;
    await db.delete(
      'ajudas_custo',
      where: 'id_custo = ?',
      whereArgs: [idCusto],
    );
  }

//---------------------------------------DESPESAS VIATURA PESSOAL-----------------------------------------

//---------------------------------------Criar tabela de despesas_viatura_pessoal
  Future<void> criarTabelaDespesasViaturaPessoal(Database db) async {
    await db.execute('''
    CREATE TABLE despesas_viatura_pessoal (
      id_despesa INTEGER PRIMARY KEY AUTOINCREMENT,
      km REAL,
      ponto_partida TEXT,
      ponto_chegada TEXT,
      preco_portagens REAL,
      comprovativo TEXT,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
  }

//---------------------------------------Inserir despesa de viatura pessoal
  Future<void> inserirDespesaViaturaPessoal(
      List<(String, String, String, String)> despesaViaturaData) async {
    Database db = await basededados;
    await db.delete('despesas_viatura_pessoal');
    for (final (ponto_partida, ponto_chegada, km, estado)
        in despesaViaturaData) {
      await db.rawInsert(
          'insert into despesas_viatura_pessoal(ponto_partida, ponto_chegada, km, estado) values(?,?,?,?)',
          [ponto_partida, ponto_chegada, km, estado]);
    }
  }

//---------------------------------------Atualizar despesa de viatura pessoal
  Future<void> atualizarDespesaViaturaPessoal(
      String idDespesa, Map<String, dynamic> despesaViatura) async {
    Database db = await basededados;
    await db.update(
      'despesas_viatura_pessoal',
      despesaViatura,
      where: 'id_despesa = ?',
      whereArgs: [idDespesa],
    );
  }

//---------------------------------------Listar todas as despesas de viatura pessoal
  Future<List<Map<String, dynamic>>> listarTodasDespesasViaturaPessoal() async {
    Database db = await basededados;
    return await db.query('despesas_viatura_pessoal');
  }

//---------------------------------------Listar despesa de viatura pessoal por id
  Future<Map<String, dynamic>?> listarDespesaViaturaPessoalPorId(
      String idDespesa) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'despesas_viatura_pessoal',
      where: 'id_despesa = ?',
      whereArgs: [idDespesa],
    );

    if (resultados.isNotEmpty) {
      return resultados.first;
    } else {
      return null;
    }
  }

//---------------------------------------Excluir despesa de viatura pessoal
  Future<void> excluirDespesaViaturaPessoal(String idDespesa) async {
    Database db = await basededados;
    await db.delete(
      'despesas_viatura_pessoal',
      where: 'id_despesa = ?',
      whereArgs: [idDespesa],
    );
  }

//---------------------------------------FALTAS-----------------------------------------

//---------------------------------------Criar tabela de faltas
  Future<void> criarTabelaFaltas(Database db) async {
    await db.execute('''
    CREATE TABLE faltas (
      id_falta INTEGER PRIMARY KEY AUTOINCREMENT,
      data TEXT,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
  }

//---------------------------------------Inserir falta
  Future<void> inserirFalta(List<(String, String, String)> faltaData) async {
    Database db = await basededados;
    await db.delete('faltas');
    for (final (data, estado, id_falta) in faltaData) {
      await db.rawInsert(
          'insert into faltas(data, estado,id_falta) values(?,?,?)',
          [data, estado, id_falta]);
    }
  }

//---------------------------------------Atualizar falta
  Future<void> atualizarFalta(
      String idFalta, Map<String, dynamic> falta) async {
    Database db = await basededados;
    await db.update(
      'faltas',
      falta,
      where: 'id_falta = ?',
      whereArgs: [idFalta],
    );
  }

//---------------------------------------Listar todas as faltas
  Future<List<Map<String, dynamic>>> listarTodasFaltas() async {
    Database db = await basededados;
    return await db.query('faltas');
  }

//---------------------------------------Listar falta por id
  Future<Map<String, dynamic>?> listarFaltaPorId(String idFalta) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'faltas',
      where: 'id_falta = ?',
      whereArgs: [idFalta],
    );

    if (resultados.isNotEmpty) {
      return resultados.first;
    } else {
      return null;
    }
  }

//---------------------------------------Excluir falta
  Future<void> excluirFalta(String idFalta) async {
    Database db = await basededados;
    await db.delete(
      'faltas',
      where: 'id_falta = ?',
      whereArgs: [idFalta],
    );
  }

//---------------------------------------HORAS-----------------------------------------

//---------------------------------------Criar tabela de horas
  Future<void> criarTabelaHoras(Database db) async {
    await db.execute('''
    CREATE TABLE horas (
      id_horas INTEGER PRIMARY KEY AUTOINCREMENT,
      horas REAL,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
  }

//---------------------------------------Inserir horas
  Future<void> inserirHoras(List<(String, String)> horasData) async {
    Database db = await basededados;
    await db.delete('horas');
    for (final (horas, estado) in horasData) {
      await db.rawInsert(
          'insert into horas(horas, estado) values(?,?)', [horas, estado]);
    }
  }

//---------------------------------------Atualizar horas
  Future<void> atualizarHoras(String idHoras, Map<String, dynamic> hora) async {
    Database db = await basededados;
    await db.update(
      'horas',
      hora,
      where: 'id_horas = ?',
      whereArgs: [idHoras],
    );
  }

//---------------------------------------Listar todas as horas
  Future<List<Map<String, dynamic>>> listarTodasHoras() async {
    Database db = await basededados;
    return await db.query('horas');
  }

//---------------------------------------Listar horas por id
  Future<Map<String, dynamic>?> listarHorasPorId(String idHoras) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'horas',
      where: 'id_horas = ?',
      whereArgs: [idHoras],
    );

    if (resultados.isNotEmpty) {
      return resultados.first;
    } else {
      return null;
    }
  }

//---------------------------------------Excluir horas
  Future<void> excluirHoras(String idHoras) async {
    Database db = await basededados;
    await db.delete(
      'horas',
      where: 'id_horas = ?',
      whereArgs: [idHoras],
    );
  }

//---------------------------------------REUNIÕES-----------------------------------------

//---------------------------------------Criar tabela de reuniões
  Future<void> criarTabelaReunioes(Database db) async {
    await db.execute('''
    CREATE TABLE reunioes (
      id_reuniao INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT,
      descricao TEXT,
      data TEXT,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
  }

//---------------------------------------Inserir reunião
  Future<void> inserirReuniao(
      List<(String, String, String)> reuniaoData) async {
    Database db = await basededados;
    await db.delete('reunioes');
    for (final (titulo, descricao, estado) in reuniaoData) {
      await db.rawInsert(
          'insert into reunioes(custo, descricao, estado) values(?,?,?)',
          [titulo, descricao, estado]);
    }
  }

//---------------------------------------Atualizar reunião
  Future<void> atualizarReuniao(
      String idReuniao, Map<String, dynamic> reuniao) async {
    Database db = await basededados;
    await db.update(
      'reunioes',
      reuniao,
      where: 'id_reuniao = ?',
      whereArgs: [idReuniao],
    );
  }

//---------------------------------------Listar todas as reuniões
  Future<List<Map<String, dynamic>>> listarTodasReunioes() async {
    Database db = await basededados;
    return await db.query('reunioes');
  }

//---------------------------------------Listar reunião por id
  Future<Map<String, dynamic>?> listarReuniaoPorId(String idReuniao) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'reunioes',
      where: 'id_reuniao = ?',
      whereArgs: [idReuniao],
    );

    if (resultados.isNotEmpty) {
      return resultados.first;
    } else {
      return null;
    }
  }

//---------------------------------------Excluir reunião
  Future<void> excluirReuniao(String idReuniao) async {
    Database db = await basededados;
    await db.delete(
      'reunioes',
      where: 'id_reuniao = ?',
      whereArgs: [idReuniao],
    );
  }
}
