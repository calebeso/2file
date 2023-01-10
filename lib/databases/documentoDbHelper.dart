import 'package:sqflite/sqflite.dart';
import 'package:to_file/databases/database_config.dart';
import 'package:to_file/models/documento.dart';

class DocumentoDbHelper {
  static final DatabaseHelper dbHelper = DatabaseHelper.instance;

  //Return Lista de documentos por id categoria
  Future<List<Documento>> listDocumentosByCategoriaId(int id) async {
    Database db = await dbHelper.database;
    var documentos = await db.query('documentos',
        orderBy: 'nome', where: 'categoria_id = ?', whereArgs: [id]);
    List<Documento> documentosList = documentos.isNotEmpty
        ? documentos.map((document) => Documento.fromMap(document)).toList()
        : [];
    return documentosList;
  }

  //lista de documentos
  Future<List<Documento>> listDocumentos() async {
    Database db = await dbHelper.database;
    var documentos = await db.query(
      'documentos',
      orderBy: 'nome',
    );
    List<Documento> documentosList = documentos.isNotEmpty
        ? documentos.map((document) => Documento.fromMap(document)).toList()
        : [];
    return documentosList;
  }

  Future<List<Documento>> getDocumentoById(int id) async {
    Database db = await dbHelper.database;
    var documentos =
        await db.query('documentos', where: 'id = ?', whereArgs: [id]);
    List<Documento> documentosList = documentos.isNotEmpty
        ? documentos.map((document) => Documento.fromMap(document)).toList()
        : [];
    return documentosList;
  }

  //adicionar Documento
  Future<int> addDocumento(Documento documento) async {
    Database db = await dbHelper.database;
    return await db.insert('documentos', documento.toMap());
  }

  //remover documento
  Future<int> removeDocumento(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('documentos', where: 'id = ?', whereArgs: [id]);
  }

  //editar documento
  Future<int> updateDocumento(Documento documento) async {
    Database db = await dbHelper.database;
    return await db.update('documentos', documento.toMap(),
        where: 'id = ?', whereArgs: [documento.id]);
  }
}
