import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_file/models/documento.dart';

class DatabaseConfig {
  static final DatabaseConfig instance = DatabaseConfig._init();

  static Database? _database;

  DatabaseConfig._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('2file.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(filePath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final nomeType = 'VARCHAR(255) NOT NULL';
    final dataCompetenciaType = 'DATE NULL';
    final dataValidadeType = 'DATE NULL';
    final criadoEmType = 'DATE NULL';

    await db.execute('''
      CREATE TABLE $tableDocumentos (
        ${DocumentoFields.id} $idType,
        ${DocumentoFields.nome} $nomeType,
        ${DocumentoFields.dataCompetencia} $dataCompetenciaType,
        ${DocumentoFields.dataValidade} $dataValidadeType,
        ${DocumentoFields.criadoEm} $criadoEmType
      )
     ''');
  }

  Future<Documento> create(Documento documento) async {
    final db = await instance.database;

    final id = await db.insert(tableDocumentos, documento.toJson());

    return documento.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
