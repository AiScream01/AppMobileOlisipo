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
  Future<void> inserirFerias(
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
Future<void> inserirParceria(Map<String, dynamic> parceria) async {
  Database db = await basededados;
  await db.insert(
    'parcerias',
    parceria,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
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



}
