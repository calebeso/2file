import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_file/databases/documentoDbHelper.dart';

import '../databases/NotificacaoDbHelper.dart';
import '../models/categoria.dart';
import '../models/documento.dart';
import '../pages/documentos/edit_documento_page.dart';
import '../pages/imagemViewPage.dart';

class ElementListView extends StatefulWidget {
  const ElementListView({
    super.key,
    required this.document,
    required this.listMonth,
    required this.categoria,
  });

  final Documento document;
  final List<Map<String, dynamic>> listMonth;
  final Categoria categoria;

  @override
  State<ElementListView> createState() => _ElementListViewState();
}

class _ElementListViewState extends State<ElementListView> {
  SampleItem? selectedMenu;
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();

  @override
  Widget build(BuildContext context) {
    final String month = widget.listMonth
        .where((element) =>
            element["value"] == widget.document.dataCompetencia?.month)
        .first['month'];

    return Card(
      color: const Color(0xffDEF1EB),
      child: ListTile(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ImagemViewPage(id_documento: widget.document.id!),
            ),
          );
        }),
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        leading: Image.asset('assets/images/icon_doc.png', height: 60),
        // NOME DOCUMENTO
        title: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(widget.document.nome,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8),
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              // COMPETÊNCIA DOCUMENTO
              const TextSpan(
                text: 'Competência: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ('$month/${widget.document.dataCompetencia.year}'),
                style: const TextStyle(color: Colors.black),
              ),
              // CATEGORIA
              const TextSpan(
                text: '\nCategoria: ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              TextSpan(
                text: (widget.categoria.nome),
                style: const TextStyle(color: Colors.black),
              ),
            ]),
          ),
        ),
        trailing: createPopupMenuButton(),
      ),
    );
  }

  createPopupMenuButton() {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          onTap: null,
          value: SampleItem.editar,
          child: Text('Editar'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.excluir,
          onTap: null,
          child: Text('Excluir'),
        ),
      ],
      onSelected: (SampleItem item) {
        setState(() {
          //selectedMenu = item;
          switch (item) {
            case SampleItem.editar:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditDocumentoPage(documento: widget.document)));
              break;
            case SampleItem.excluir:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 5.0,
                  title: Text(
                      "Deseja excluir ${widget.document.nome} definitivamente?"),
                  actions: [
                    MaterialButton(
                      child: const Text("Sim"),
                      onPressed: () {
                        _documentoDbHelper.removeDocumento(widget.document.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Documento excluído com sucesso!"),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color(0xffFE7C3F),
                          ),
                        );
                        _excluirNotificacao(widget.document.id!);
                        _deletarImagem(widget.document.nome_imagem);
                        Navigator.pop(context);
                      },
                    ),
                    MaterialButton(
                      child: const Text('Não'),
                      onPressed: () {},
                    )
                  ],
                ),
              );
              break;
          }
        });
      },
    );
  }
}

enum SampleItem {
  editar,
  excluir,
}

_excluirNotificacao(int id_documento) async {
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  await _notifyDbHelper.removerNotificacaoByIdDocumento(id_documento);
}

_deletarImagem(String nomeImagem) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final path = Path.join(directory.path, nomeImagem);
  bool isExist = await File(path).exists();
  if (isExist) {
    await File(path).delete();
  }
}
