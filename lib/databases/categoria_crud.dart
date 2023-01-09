import 'package:sqflite/sqflite.dart';

import '../models/categoria.dart';
import 'database_config.dart';

class CategoriaCrud {
  static final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<List<Categoria>> getCategoriaById(int id) async {
    Database db = await dbHelper.database;
    var categorias =
        await db.query('categorias', where: 'id = ?', whereArgs: [id]);
    //alterar o orderby para id_categoria
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    return categoriaList;
  }

  //Return Lista de dcategorias
  Future<List<Categoria>> listCategoriaById() async {
    Database db = await dbHelper.database;
    var categorias = await db.query('categorias', orderBy: 'id');
    List<Categoria> categoriaList = categorias.isNotEmpty
        ? categorias.map((e) => Categoria.fromMap(e)).toList()
        : [];
    return categoriaList;
  }

  //adicionar Categoria
  Future<int> addCategoria(Categoria categoria) async {
    Database db = await dbHelper.database;
    return await db.insert('categorias', categoria.toMap());
  }

  //remover categoria
  Future<int> removeCategoria(int id) async {
    Database db = await dbHelper.database;
    return await db.delete('categorias', where: 'id = ?', whereArgs: [id]);
  }

  //editar categoria
  Future<int> updateCategoria(Categoria categoria) async {
    Database db = await dbHelper.database;
    return await db.update('categorias', categoria.toMap(),
        where: 'id = ?', whereArgs: [categoria.id]);
  }
}
