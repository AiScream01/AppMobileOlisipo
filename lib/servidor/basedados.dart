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
  Future _onCreate(Database db, int version) async {
    await criatabelaUtilizadores(db); // Chama o método para criar a tabela de utilizadores
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
  Future<void> inserirUtilizador(String nome, String email, String palavrapasse) async {
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
  Future<void> atualizarUtilizador(int id, String nome, String email, String palavrapasse) async {
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
Future<void> inserirFerias(DateTime dataInicio, DateTime dataFim, int idUser) async {
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
    return resultados.first; // Retorna o primeiro (e único) registro encontrado
  } else {
    return null; // Retorna null se nenhum registro for encontrado
  }
}


}
