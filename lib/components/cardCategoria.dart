import 'package:flutter/material.dart';
import 'package:to_file/databases/categoria_crud.dart';
import 'package:to_file/models/icones.dart';

import '../models/categoria.dart';
import '../pages/categoria_page.dart';
import '../pages/newCategoriaPage.dart';

class CardCategoria extends StatefulWidget {
  final Categoria categoria;
  final atualizarListaCategorias;

  CardCategoria({required this.categoria, this.atualizarListaCategorias});

  @override
  State<CardCategoria> createState() => _CardCategoriaState();
}

class _CardCategoriaState extends State<CardCategoria> {
  CategoriaCrud categoriaCrud = CategoriaCrud();

  Offset _tapPosition = Offset.zero;

  void _getTapPosition(TapDownDetails tapPosition) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition.globalPosition);
      print(_tapPosition);
    });
  }

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();
    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: [
          PopupMenuItem(
              value: "edit",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Icon(Icons.edit), Text('Editar')],
              )),
          PopupMenuItem(
              value: "delete",
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Icon(Icons.delete), Text('Excluir')]))
        ]);

    switch (result) {
      case 'delete':
        Future.delayed(
            const Duration(seconds: 0),
            () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Excluir Categoria'),
                      content: Text(
                          'Tem certeza que deseja excluir a categoria: ${widget.categoria.nome}?'),
                      actions: [
                        ElevatedButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () async {
                            await categoriaCrud
                                .removeCategoria(widget.categoria.id!);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )));
        break;

      case 'edit':
        Future.delayed(
            const Duration(seconds: 0),
            () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => NewCategoriaPage(
                                atualizarListaCategorias:
                                    widget.atualizarListaCategorias,
                                categoria: widget.categoria,
                              )))
                });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    CategoriaPage(categoria: widget.categoria)));
      },
      onTapDown: (position) {
        _getTapPosition(position);
      },
      onLongPress: () {
        _showContextMenu(context);
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
