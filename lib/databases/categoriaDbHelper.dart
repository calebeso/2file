import 'package:sqflite/sqflite.dart';

import '../models/categoria.dart';
import 'database_config.dart';

class CategoriaDbHelper {
  static final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<List<Categoria>> getCategoriaById(int id) async {
    Database db = await dbHelper.database;
    var categorias =
        await db.query('categorias', where: 'id = ?', whereArgs: [id]);
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    return categoriaList;
  }

  Future<List<Categoria>> listCategoriaById() async {
    Database db = await dbHelper.database;
    var categorias = await db.query('categorias', orderBy: 'id');
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    return categoriaList;
  }

  Future<int> addCategoria(Categoria categoria) async {
    Database db = await dbHelper.database;
    return await db.insert('categorias', categoria.toMap());
  }

  Future<int> removeCategoria(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('categorias', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCategoria(Categoria categoria) async {
    Database db = await dbHelper.database;
    return await db.update('categorias', categoria.toMap(),
        where: 'id = ?', whereArgs: [categoria.id]);
  }

  Future<List<Categoria>> getCategoriesByListId(List<int> idList) async {
    Database db = await dbHelper.database;
    var categorias = await db.query('categorias',
        where: 'id IN (${idList.map((_) => "?").join(", ")})',
        whereArgs: idList);
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    return categoriaList;
  }
}
