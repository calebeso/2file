import 'package:intl/intl.dart';
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

  Future<Documento> getDocumentoById(int id) async {
    Database db = await dbHelper.database;
    var documentos =
        await db.query('documentos', where: 'id = ?', whereArgs: [id]);
    List<Documento> documentosList = documentos.isNotEmpty
        ? documentos.map((document) => Documento.fromMap(document)).toList()
        : [];
    Documento? documento;
    for (Documento doc in documentosList) {
      documento = doc;
    }
    return documento!;
  }

  //adicionar Documento
  Future<void> addDocumento(Documento documento) async {
    Database db = await dbHelper.database;
    await db.insert('documentos', documento.toMap());
  }

  //remover documento
  Future<int> removeDocumento(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('documentos', where: 'id = ?', whereArgs: [id]);
  }

  //editar documento
  Future<void> updateDocumento(Documento documento) async {
    Database db = await dbHelper.database;
    await db.update('documentos', documento.toMap(),
        where: 'id = ?', whereArgs: [documento.id]);
  }

  // get documento by id notificação
  Future<List<Documento>> getDocumentoByIdNotificacao(int id_documento) async {
    Database db = await dbHelper.database;
    var documentos = await db.query('documento',
        where: 'id_documento = ?', whereArgs: [id_documento]);
    //alterar o orderby para id_categoria
    List<Documento> documentosList = documentos.isNotEmpty
        ? documentos.map((e) => Documento.fromMap(e)).toList()
        : [];

    return documentosList;
  }

  Future<String> getTextoNotificacao(int id_documento) async {
    String? textoNotificacao;
    Database db = await dbHelper.database;
    var documentos = await db.query('documento',
        where: 'id_documento = ?', whereArgs: [id_documento]);
    //alterar o orderby para id_categoria
    List<Documento> documentosList = documentos.isNotEmpty
        ? documentos.map((e) => Documento.fromMap(e)).toList()
        : [];

    for (Documento doc in documentosList) {
      textoNotificacao =
          "O documento ${doc.nome?.toUpperCase()} venceu em ${DateFormat("dd/MM/yyyy").format(doc.dataValidade!)}";
    }

    return textoNotificacao!;
  }

  // Future<List<Documento>> getDocumentoByIdNotificacao(int id_documento) async {
  //   Database db = await dbHelper.database;
  //   var documentos = await db.rawQuery(''',
  //   SELECT *
  //   FROM documentos
  //   WHERE documentos.id = notificacoes.$id_documento
  //   ''');
  //   List<Documento> documentosList = documentos.isNotEmpty
  //       ? documentos.map((e) => Documento.fromMap(e)).toList()
  //       : [];
  //   Documento? documento;
  //   for (Documento doc in documentosList) {
  //     documento = doc;
  //   }
  //   return documento!;
  // }
}
