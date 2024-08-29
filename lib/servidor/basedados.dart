import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // Para usar jsonEncode
import 'package:http/http.dart' as http; // Para usar http.post

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
  Future _onCreate(Database db, int version) async {
    await criatabelaUtilizadores(
        db); // Chama o método para criar a tabela de utilizadores
    await criatabelaFerias(db); // Chama o método para criar a tabela de férias
  }

  //---------------------------------------UTILIZADORES-----------------------------------------

  //---------------------------------------Criar tabela de utilizadores
  Future<void> criatabelaUtilizadores(Database db) async {
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

  //---------------------------------------FÉRIAS-----------------------------------------

//---------------------------------------Criar tabela de férias
  Future<void> criatabelaFerias(Database db) async {
    await db.execute('''
    CREATE TABLE ferias (
      id_ferias INTEGER PRIMARY KEY AUTOINCREMENT,
      data_inicio TEXT,
      data_fim TEXT,
      id_user INTEGER,
      FOREIGN KEY (id_user) REFERENCES utilizadores (id_user)
    )
  ''');
  }

//---------------------------------------Inserir férias
  Future<void> InsertFerias(
      DateTime dataInicio, DateTime dataFim, int idUser) async {
    Database db = await basededados;
    await db.insert(
      'ferias',
      {
        'data_inicio': dataInicio.toIso8601String(),
        'data_fim': dataFim.toIso8601String(),
        'id_user': idUser,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//---------------------------------------Listar todas as férias
  Future<List<Map<String, dynamic>>> listarTodasFerias() async {
    Database db = await basededados;
    return await db.query('ferias');
  }

//---------------------------------------Listar férias pelo id
  Future<Map<String, dynamic>?> listarFeriasPorId(int id) async {
    Database db = await basededados;
    List<Map<String, dynamic>> resultados = await db.query(
      'ferias',
      where: 'id_ferias = ?',
      whereArgs: [id],
    );

    if (resultados.isNotEmpty) {
      return resultados
          .first; // Retorna o primeiro (e único) registro encontrado
    } else {
      return null; // Retorna null se nenhum registro for encontrado
    }
  }

  Future<bool> enviarPedidoFeriasParaServidor({
    required DateTime dataInicio,
    required DateTime dataFim,
    required int idUser,
  }) async {
    final url = Uri.parse(
        'https://seuservidor.com/api/ferias'); // Substitua pela URL real do seu servidor

    // Faz a requisição POST
    final response = await http.post(
      url,
      headers: {
        'Content-Type':
            'application/json', // Define o tipo de conteúdo como JSON
      },
      body: jsonEncode({
        'data_inicio': dataInicio.toIso8601String(),
        'data_fim': dataFim.toIso8601String(),
        'id_user': idUser,
      }),
    );

    if (response.statusCode == 200) {
      // Se o servidor retornar status 200, significa que a operação foi bem-sucedida
      return true;
    } else {
      // Caso contrário, exibe o erro no console
      print('Erro ao enviar dados para o servidor: ${response.statusCode}');
      return false;
    }
  }

    //---------------------------------------PARCERIAS-----------------------------------------

    //---------------------------------------Criar tabela de parcerias
Future<void> criatabelaParcerias(Database db) async {
  await db.execute('''
    CREATE TABLE parcerias (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idParceria TEXT UNIQUE NOT NULL,
      nome TEXT,
      descricao TEXT,
      dataCriacao TEXT,
      ultimaAtualizacao TEXT,
      sincronizado INTEGER DEFAULT 0
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
          ' INSERT INTO protocolos_parcerias ( logotipo, titulo,descricao,categoria) VALUES (?,?,?,?)',
          [
            logotipo,
            titulo,
            descricao,
            categoria
          ]);
      print(titulo);
    }
  }

//---------------------------------------Atualizar parceria
Future<void> atualizarParceria(String idParceria, Map<String, dynamic> parceria) async {
  Database db = await basededados;
  await db.update(
    'parcerias',
    parceria,
    where: 'idParceria = ?',
    whereArgs: [idParceria],
  );
}

//---------------------------------------Listar todas as parcerias
Future<List<Map<String, dynamic>>> listarTodasParcerias() async {
  Database db = await basededados;
  return await db.query('parcerias');
}

//---------------------------------------Listar parceria por id
Future<Map<String, dynamic>?> listarParceriaPorId(String idParceria) async {
  Database db = await basededados;
  List<Map<String, dynamic>> resultados = await db.query(
    'parcerias',
    where: 'idParceria = ?',
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
    'parcerias',
    where: 'idParceria = ?',
    whereArgs: [idParceria],
  );
}


//---------------------------------------NOTICIAS-----------------------------------------

//---------------------------------------Criar tabela de notícias
Future<void> criarTabelaNoticias(Database db) async {
  await db.execute('''
    CREATE TABLE noticias (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_noticia TEXT UNIQUE NOT NULL,
      titulo TEXT,
      descricao TEXT,
      data TEXT,
      imagem TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
}

//---------------------------------------Inserir notícia
Future<void> inserirNoticia(
      List<(String, String, String, String)> noticiaData) async {
    Database db = await basededados;

    await db.delete('parcerias');

    for (final (
          titulo,
          descricao,
          data,
          imagem,
        ) in noticiaData) {
      await db.rawInsert(
          ' INSERT INTO parcerias ( titulo, descricao,data,imagem) VALUES (?,?,?,?)',
          [
            titulo,
            descricao,
            data,
            imagem
          ]);
      print(titulo);
    }
  }

//---------------------------------------Atualizar notícia
Future<void> atualizarNoticia(String idNoticia, Map<String, dynamic> noticia) async {
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_custo TEXT UNIQUE NOT NULL,
      custo REAL,
      descricao TEXT,
      comprovativo TEXT,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
}

//---------------------------------------Inserir ajuda de custo
Future<void> inserirAjudaCusto(Map<String, dynamic> ajudaCusto) async {
  Database db = await basededados;
  await db.insert(
    'ajudas_custo',
    ajudaCusto,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//---------------------------------------Atualizar ajuda de custo
Future<void> atualizarAjudaCusto(String idCusto, Map<String, dynamic> ajudaCusto) async {
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_despesa TEXT UNIQUE NOT NULL,
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
Future<void> inserirDespesaViaturaPessoal(Map<String, dynamic> despesaViatura) async {
  Database db = await basededados;
  await db.insert(
    'despesas_viatura_pessoal',
    despesaViatura,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//---------------------------------------Atualizar despesa de viatura pessoal
Future<void> atualizarDespesaViaturaPessoal(String idDespesa, Map<String, dynamic> despesaViatura) async {
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
Future<Map<String, dynamic>?> listarDespesaViaturaPessoalPorId(String idDespesa) async {
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_falta TEXT UNIQUE NOT NULL,
      data TEXT,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
}

//---------------------------------------Inserir falta
Future<void> inserirFalta(Map<String, dynamic> falta) async {
  Database db = await basededados;
  await db.insert(
    'faltas',
    falta,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//---------------------------------------Atualizar falta
Future<void> atualizarFalta(String idFalta, Map<String, dynamic> falta) async {
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_horas TEXT UNIQUE NOT NULL,
      horas REAL,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
}

//---------------------------------------Inserir horas
Future<void> inserirHoras(Map<String, dynamic> hora) async {
  Database db = await basededados;
  await db.insert(
    'horas',
    hora,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_reuniao TEXT UNIQUE NOT NULL,
      titulo TEXT,
      descricao TEXT,
      data TEXT,
      id_user TEXT,
      sincronizado INTEGER DEFAULT 0
    )
  ''');
}

//---------------------------------------Inserir reunião
Future<void> inserirReuniao(Map<String, dynamic> reuniao) async {
  Database db = await basededados;
  await db.insert(
    'reunioes',
    reuniao,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//---------------------------------------Atualizar reunião
Future<void> atualizarReuniao(String idReuniao, Map<String, dynamic> reuniao) async {
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
