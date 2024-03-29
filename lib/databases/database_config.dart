import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_file/models/categoria.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'twoFile.db');

    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(documentos);
    await db.execute(categoria);
    await db.execute(notificacoes);
    await _populateDefaultCategoria(db);
  }

  Future _populateDefaultCategoria(Database db) async {
    List<dynamic> categorias = [
      Categoria(
          nome: 'Recibo', nomeIcone: 'recibo.png', criadoEm: DateTime.now()),
      Categoria(
          nome: 'Fatura', nomeIcone: 'fatura.png', criadoEm: DateTime.now()),
      Categoria(
          nome: 'Extrato Bancário',
          nomeIcone: 'extrato-bancario.png',
          criadoEm: DateTime.now()),
      Categoria(
          nome: 'Nota Fiscal',
          nomeIcone: 'notaFiscal.png',
          criadoEm: DateTime.now()),
      Categoria(
          nome: 'Contrato',
          nomeIcone: 'contrato.png',
          criadoEm: DateTime.now()),
      Categoria(
          nome: 'Boleto', nomeIcone: 'boleto.png', criadoEm: DateTime.now()),
      Categoria(
          nome: 'Pessoal', nomeIcone: 'pessoal.png', criadoEm: DateTime.now())
    ];

    for (var categoria in categorias) {
      await db.rawInsert('''
        INSERT INTO categorias (nome,nomeIcone,criadoEm)
        VALUES (?, ?, ?)''', [
        categoria.nome,
        categoria.nomeIcone,
        categoria.criadoEm.toIso8601String()
      ]);
    }
  }

  String documentos = '''
    CREATE TABLE documentos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome VARCHAR(255) NOT NULL, 
      dataCompetencia DATE NULL,
      dataValidade DATE NULL,
      nome_imagem VARCHAR(255) NOT NULL, 
      criadoEm DATE NULL,
      categoria_id INT NOT NULL, 
      FOREIGN KEY (categoria_id) REFERENCES categorias (id)
    )''';

  String notificacoes = '''
    CREATE TABLE notificacoes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      criadoEm DateTime,
      body TEXT,
      id_documento INT,
      FOREIGN KEY (id_documento) REFERENCES documentos (id)
    )''';

  String categoria = '''
    CREATE TABLE categorias(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      nomeIcone TEXT,
      criadoEm DateTime
    )
    ''';

  // ============CATEGORIA ==============================================
  Future<List<Categoria>> getCategoriaById(int id) async {
    Database db = await instance.database;
    var categorias =
        await db.query('categorias', where: 'id = ?', whereArgs: [id]);
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    return categoriaList;
  }

  //retorna uma categoria específica.
  Future<Categoria> getCategoria(int id) async {
    Database db = await instance.database;
    Categoria? cat;
    var categorias =
        await db.query('categorias', where: 'id = ?', whereArgs: [id]);
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    for (Categoria c in categoriaList) {
      cat = c;
    }
    return cat!;
  }

  // Retorna todas as categorias
  Future<List<Categoria>> todasCategorias() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db.query('categorias');
    List<Categoria> categorias =
        allRows.map((categoria) => Categoria.fromMap(categoria)).toList();
    return categorias;
  }

  //Retorna categoria por ID
  Future<List<Categoria>> listCategoriaById() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db.query('categorias');
    List<Categoria> categorias =
        allRows.map((categoria) => Categoria.fromMap(categoria)).toList();
    return categorias;
  }
}
