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
        // position: RelativeRect.fromRect(
        //     Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 50, 50),
        //     Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
        //         overlay!.paintBounds.size.height)),
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: [
          PopupMenuItem(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
                const Text('Editar'),
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Excluir categoria?'),
                              actions: [
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const ElevatedButton(
                                  child: Text('OK'),
                                  onPressed: null,
                                  // () async {
                                  // await categoriaCrud.removeCategoria(id);
                                  // _atualizarListaContatos();
                                  // Navigator.pop(context);
                                  // },
                                )
                              ],
                            );
                          },
                        );
                  },
                ),
                const Text('Deletar'),
              ],
            ),
          ),
        ]);
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

// void deletarCategoria() async {
//   await categoriaCrud.removeCategoria();
// }
}

// class CardCategoria extends StatelessWidget {
//   final Categoria categoria;
//
//   CardCategoria({required this.categoria});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (BuildContext context) =>
//                     CategoriaPage(id: categoria.id!)));
//       },
//       child: Container(
//         height: 100.0,
//         width: 100.0,
//         padding: const EdgeInsets.all(8),
//         // color: const Color(0xffEAEBD9),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: const <BoxShadow>[
//             BoxShadow(
//               color: Colors.black38,
//               blurRadius: 5.0,
//               offset: Offset(0.0, 0.80),
//             ),
//           ],
//         ),
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // se for do tipo imagem
//             categoria.nomeIcone.contains('png') == true
//                 ? IconButton(
//                     onPressed: null,
//                     icon: ImageIcon(
//                       AssetImage('assets/images/${categoria.nomeIcone}'),
//                       color: const Color(0xffFE7C3F),
//                       size: 40,
//                     ),
//                   )
//
//                 // se for icone
//                 : Icon(
//                     Icones.mIcons[categoria.nomeIcone],
//                     color: const Color(0xffFE7C3F),
//                     size: 40,
//                   ),
//             Text(categoria.nome, textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }
// }
