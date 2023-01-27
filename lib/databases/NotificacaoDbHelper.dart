import 'package:sqflite/sqflite.dart';
import 'package:to_file/databases/database_config.dart';

import '../models/notificacao.dart';

class NotifyDbHelper {
  static final DatabaseHelper dbHelper = DatabaseHelper.instance;

  // ============NOTIFICAÇÕES ==============================================

  //Get notificação por id
  Future<Notificacao> getNotificacaoByIdDocumento(int id_documento) async {
    Database db = await dbHelper.database;
    var notificacoes = await db.query('notificacoes',
        where: 'id_documento = ?', whereArgs: [id_documento]);
    //alterar o orderby para id_categoria
    List<Notificacao> notificacaoList = notificacoes.isNotEmpty
        ? notificacoes.map((e) => Notificacao.fromMap(e)).toList()
        : [];
    Notificacao? notificacao;
    for (Notificacao notify in notificacaoList) {
      notificacao = notify;
    }
    return notificacao!;
  }

  //Lista de notificacoes
  Future<List<Notificacao>> listaNotificacoes() async {
    Database db = await dbHelper.database;
    var notificacoes = await db.query('notificacoes');
    List<Notificacao> notificacoesList = notificacoes.isNotEmpty
        ? notificacoes.map((e) => Notificacao.fromMap(e)).toList()
        : [];
    return notificacoesList;
  }

  //adicionar notificacao
  Future<void> addNotificacao(Notificacao notificacao) async {
    Database db = await dbHelper.database;
    await db.insert('notificacoes', notificacao.toMap());
  }

  //remover notificacao
  Future<void> removeNotificacao(int id) async {
    Database db = await dbHelper.database;
    await db.delete('notificacoes', where: 'id = ?', whereArgs: [id]);
  }

  //remover todas as notificações
  Future<void> removerTodasNotificacoes() async {
    Database db = await dbHelper.database;
    String sqlDelete = '''
        DELETE FROM notificacoes;
    ''';
    await db.rawDelete(sqlDelete);
  }
}
