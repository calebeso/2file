import 'package:flutter/material.dart';
import 'package:to_file/databases/categoriaDbHelper.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/icones.dart';
import 'package:to_file/pages/categoria_page2.dart';

import '../models/categoria.dart';
import '../models/documento.dart';
import '../pages/newCategoriaPage.dart';

class CardCategoria extends StatefulWidget {
  final Categoria categoria;
  final atualizarListaCategorias;

  CardCategoria({required this.categoria, this.atualizarListaCategorias});

  @override
  State<CardCategoria> createState() => _CardCategoriaState();
}

class _CardCategoriaState extends State<CardCategoria> {
  CategoriaDbHelper categoriaCrud = CategoriaDbHelper();
  DocumentoDbHelper documentoDb = DocumentoDbHelper();

  final widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: widgetKey,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    CategoriaPage2(categoria: widget.categoria)));
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onLongPress: () {
        createShowMenu(context);
      },
      child: Container(
        height: 100.0,
        width: 100.0,
        padding: const EdgeInsets.all(8),
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
            Expanded(
              child: Text(widget.categoria.nome,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  void createShowMenu(BuildContext context) async {
    final result = await showMenu(
        context: context,
        position: _getRelativeRect(widgetKey),
        items: <PopupMenuEntry>[
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
                children: const [Icon(Icons.delete), Text('Excluir')]),
          ),
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
                            // Verificar se tem documento vinculado
                            List<Documento> docList =
                                await documentoDb.listDocumentosByCategoriaId(
                                    widget.categoria.id!);

                            if (docList.isEmpty) {
                              await categoriaCrud
                                  .removeCategoria(widget.categoria.id!);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("Categoria excluída com sucesso!"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Color(0xffFE7C3F),
                              ));
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              showDeleteCategoryNotEmptyDialog();
                            }
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
                      ),
                    ),
                  ),
                });
        break;
    }
  }

  RelativeRect _getRelativeRect(GlobalKey key) {
    return RelativeRect.fromSize(
        _getWidgetGlobalRect(key), const Size(200, 200));
  }

  Rect _getWidgetGlobalRect(GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    debugPrint('Widget position: ${offset.dx} ${offset.dy}');
    return Rect.fromLTWH(offset.dx / 3.1, offset.dy * 1.05,
        renderBox.size.width, renderBox.size.height);
  }

  showDeleteCategoryNotEmptyDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Icon(Icons.warning_rounded, size: 30, color: Colors.yellow),
        content: const Text(
            "Categoria contém documento vinculado e não pode ser excluída"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
