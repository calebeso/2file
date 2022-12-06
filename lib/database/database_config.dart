import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_file/models/categoria.dart';
import 'package:to_file/models/notificacao.dart';

import '../models/categoria.dart';
import '../models/documento.dart';
import '../models/notificacao.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'twoFile.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(documentos);
    await db.execute(notificacoes);
    await db.execute(categorias);
  }

  String documentos = '''
    CREATE TABLE documentos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      data_competencia TEXT,
      data_validade TEXT,
      criado_em TEXT
    )''';

  String notificacoes = '''
    CREATE TABLE notificacoes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      criado_em TEXT
    )''';

  String categorias = '''
    CREATE TABLE categorias(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      criado_em TEXT
    )''';

  //return

  //Return Lista de documentos
  Future<List<Documento>> listDocumentos() async {
    Database db = await instance.database;
    var documentos = await db.query('documentos', orderBy: 'nome');
    //alterar o orderby para id_categoria
    List<Documento> documentosList = documentos.isNotEmpty
        ? documentos.map((e) => Documento.fromMap(e)).toList()
        : [];
    return documentosList;
  }

  //adicionar Documento
  Future<int> addDocumento(Documento documento) async {
    Database db = await instance.database;
    return await db.insert('documentos', documento.toMap());
  }

  //remover documento
  Future<int> removeDocumento(int id) async {
    Database db = await instance.database;
    return await db.delete('documentos', where: 'id = ?', whereArgs: [id]);
  }

  //editar documento
  Future<int> updateDocumento(Documento documento) async {
    Database db = await instance.database;
    return await db.update('documentos', documento.toMap(),
        where: 'id = ?', whereArgs: [documento.id]);
  }

  //Return Lista de dcategorias
  Future<List<Categoria>> listCategoriaById() async {
    Database db = await instance.database;
    var categorias = await db.query('categorias', orderBy: 'id');
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    return categoriaList;
  }

  //adicionar Categoria
  Future<int> addCategoria(Categoria categoria) async {
    Database db = await instance.database;
    return await db.insert('categorias', categoria.toMap());
  }

  //remover categoria
  Future<int> removeCategoria(int id) async {
    Database db = await instance.database;
    return await db.delete('categorias', where: 'id = ?', whereArgs: [id]);
  }

  //editar categoria
  Future<int> updateCategoria(Categoria categoria) async {
    Database db = await instance.database;
    return await db.update('categorias', categoria.toMap(),
        where: 'id = ?', whereArgs: [categoria.id]);
  }

  //Return Lista de dcategorias
  Future<List<Notificacao>> listNotificacoes() async {
    Database db = await instance.database;
    var notificacoes = await db.query('notificacoes', orderBy: 'id');
    List<Notificacao> notificacoesList = notificacoes.isNotEmpty
        ? notificacoes.map((e) => Notificacao.fromMap(e)).toList()
        : [];
    return notificacoesList;
  }

  //adicionar Notificacao
  Future<int> addNotificacao(Notificacao notificacao) async {
    Database db = await instance.database;
    return await db.insert('categorias', notificacao.toMap());
  }

  //remover notificacao
  Future<int> removeNotificacao(int id) async {
    Database db = await instance.database;
    return await db.delete('notificacoes', where: 'id = ?', whereArgs: [id]);
  }

  //editar categoria
  Future<int> updateNotificacao(Notificacao notificacao) async {
    Database db = await instance.database;
    return await db.update('notificacoes', notificacao.toMap(),
        where: 'id = ?', whereArgs: [notificacao.id]);
  }
}
