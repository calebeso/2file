import 'package:sqflite/sqflite.dart';
import 'package:to_file/databases/database_config.dart';

import '../models/notificacoes.dart';

class NotifyDbHelper{

  static final DatabaseHelper dbHelper = DatabaseHelper.instance;

  // ============NOTIFICAÇÕES ==============================================

  //Get notificação por id
  Future<List<Notificacao>> getNotificacaoByIdDocumento(
      int id_documento) async {
    Database db = await dbHelper.database;
    var notificacoes = await db.query('notificacoes',
        where: 'id_documento = ?', whereArgs: [id_documento]);
    //alterar o orderby para id_categoria
    List<Notificacao> notificacaoList = notificacoes.isNotEmpty
        ? notificacoes.map((e) => Notificacao.fromMap(e)).toList()
        : [];
    return notificacaoList;
  }

  //Lista de notificacoes
  Future<List<Notificacao>> listaNotificacoes() async {
    Database db = await dbHelper.database;
    var notificacoes = await db.query('notificacoes', orderBy: 'id');
    List<Notificacao> notificacoesList = notificacoes.isNotEmpty
        ? notificacoes.map((e) => Notificacao.fromMap(e)).toList()
        : [];
    return notificacoesList;
  }

  //adicionar notificacao
  Future<int> addNotificacao(Notificacao notificacao) async {
    Database db = await dbHelper.database;
    return await db.insert('notificacoes', notificacao.toMap());
  }

  //remover notificacao
  Future<int> removeNotificacao(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('notificacoes', where: 'id = ?', whereArgs: [id]);
  }

}