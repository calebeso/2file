import 'package:flutter/material.dart';
import 'package:to_file/models/categoria.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_file/databases/database_config.dart';

class CategoriaDropdown extends StatefulWidget {
  List<Categoria> categorias;

  Function(Categoria) callback;

  CategoriaDropdown(
    this.categorias,
    this.callback, {
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriaDropdown> createState() => _CategoriasDropDownState();
}

class _CategoriasDropDownState extends State<CategoriaDropdown> {
  @override
  Widget build(BuildContext context) {
    DropdownButton<Categoria>(
      hint: Text('Selecione uma categoria'),
      onChanged: (value) {},
      items:  DatabaseHelper.instance.todasCategorias();
    );
  }
}
