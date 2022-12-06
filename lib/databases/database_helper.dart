import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_file/models/categoria.dart';

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
    // await db.execute(notificacoes);
    await db.execute(categoria);
    await _populateDefaultCategoria(db);
  }


  Future _populateDefaultCategoria(Database db) async {
    List<dynamic> categorias = [
      Categoria(id: 0, nome: 'Recibo', nomeIcone: 'recibo.png', criadoEm: DateTime.now()),
      Categoria(id: 1, nome: 'Fatura', nomeIcone: 'fatura.png', criadoEm: DateTime.now()),
      Categoria(id: 2, nome: 'Extrato Bancário', nomeIcone: 'extrato-bancario.png', criadoEm: DateTime.now()),
      Categoria(id: 3, nome: 'Nota Fiscal', nomeIcone: 'notaFiscal.png', criadoEm: DateTime.now()),
      Categoria(id: 4, nome: 'Contrato', nomeIcone: 'contrato.png', criadoEm: DateTime.now()),
      Categoria(id: 5, nome: 'Boleto', nomeIcone: 'boleto.png', criadoEm: DateTime.now()),
      Categoria(id: 6, nome: 'Pessoal', nomeIcone: 'pessoal.png', criadoEm: DateTime.now())
    ];

    for (var categoria in categorias) {
      addCategoria(categoria);
    }
  }

  String documentos =
  '''
    CREATE TABLE documentos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT
    )''';

  String notificacoes =
  '''
    CREATE TABLE notificacoes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
    )''';

  String categoria =
  '''
    CREATE TABLE categorias(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      nomeIcone TEXT,
      criadoEm DateTime
    )
    ''';

  // //Return Lista de documentos
  // Future<List> listDocumentos() async {
  //   Database db = await instance.database;
  //   var documentos = await db.query('documentos', orderBy: 'nome');
  //   //alterar o orderby para id_categoria
  //   List documentosList = documentos.isNotEmpty
  //       ? documentos.map((e) => Documento.fromMap(e)).toList()
  //       : [];
  //   return documentosList;
  // }
  //
  // //adicionar Documento
  // Future<int> addDocumento(Documento documento) async {
  //   Database db = await instance.database;
  //   return await db.insert('documentos', documento.toMap());
  // }
  //
  // //remover documento
  // Future<int> removeDocumento(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete('documentos', where: 'id = ?', whereArgs: [id]);
  // }
  //
  // //editar documento
  // Future<int> updateDocumento(Documento documento) async {
  //   Database db = await instance.database;
  //   return await db.update('documentos', documento.toMap(),
  //       where: 'id = ?', whereArgs: [documento.id]);
  // }


  // =============== CATEGORIA ==============================================================

  //Return Lista de categorias
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

  //atualizar categoria
  Future<int> updateCategoria(Categoria categoria) async {
    Database db = await instance.database;
    return await db.update('categorias', categoria.toMap(),
        where: 'id = ?', whereArgs: [categoria.id]);
  }
}