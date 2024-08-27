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
  _initDatabase() async {
    String path = join(await getDatabasesPath(), nomebd);
    return await openDatabase(path, version: versao, onCreate: _onCreate);
  }

  //---------------------------------------
  Future _onCreate(Database db, int version) async {
    await criatabela(db); // Chama o método para criar a tabela ao inicializar o banco de dados
  }


  //---------------------------------------UTILIZADORES-----------------------------------------

  //---------------------------------------Criar tabela
  Future<void> criatabela(Database db) async {
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
    await db.rawInsert(
      'INSERT INTO utilizadores (nome, email, palavrapasse) VALUES (?, ?, ?)',
      [nome, email, palavrapasse]
    );
  }

  //---------------------------------------Listar utilizadores
  Future<List<Map<String, dynamic>>> listarUtilizadores() async {
  Database db = await basededados;
  return await db.query('utilizadores');
  }

  //---------------------------------------Listar utilizador pelo id
  Future<Map<String, dynamic>?> listarUtilizadorPorId(int id) async {
  Database db = await basededados;
  List<Map<String, dynamic>> resultados = await db.query(
      'utilizadores',
      where: 'id_user = ?',
      whereArgs: [id],
    );

    if (resultados.isNotEmpty) {
      return resultados.first; // Retorna o primeiro (e único) registro encontrado
    } else {
      return null; // Retorna null se nenhum registo for encontrado
    }
  }


  //--------------------------------------------------------------------------------------------

}
