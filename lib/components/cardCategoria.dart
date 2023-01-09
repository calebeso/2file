import 'package:flutter/material.dart';
import 'package:to_file/databases/categoria_crud.dart';
import 'package:to_file/models/icones.dart';

import '../models/categoria.dart';
import '../pages/categoria_page.dart';

class CardCategoria extends StatefulWidget {
  final Categoria categoria;
  // List<Categoria> categorias = [];
  CardCategoria({required this.categoria});

  @override
  State<CardCategoria> createState() => _CardCategoriaState();
}

class _CardCategoriaState extends State<CardCategoria> {
  CategoriaCrud categoriaCrud = CategoriaCrud();

  void mostrarDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Deseja excluir categoria?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancelar'),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    CategoriaPage(id: widget.categoria.id!)));
      },
      onTapDown: (position) {},
      onLongPress: () {
        // _showContextMenu(context);
        //mostrarDialog();
      },
      child: Container(
        height: 100.0,
        width: 100.0,
        padding: const EdgeInsets.all(8),
        // color: const Color(0xffEAEBD9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(0.0, 0.80),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // se for do tipo imagem
            widget.categoria.nomeIcone.contains('png') == true
                ? IconButton(
                    onPressed: null,
                    icon: ImageIcon(
                      AssetImage('assets/images/${widget.categoria.nomeIcone}'),
                      color: const Color(0xffFE7C3F),
                      size: 40,
                    ),
                  )

                // se for icone
                : Icon(
                    Icones.mIcons[widget.categoria.nomeIcone],
                    color: const Color(0xffFE7C3F),
                    size: 40,
                  ),
            Text(widget.categoria.nome, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
