import 'package:flutter/material.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/pages/imagemViewPage.dart';

import '../models/categoria.dart';
import '../models/documento.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        //color: Colors.lime,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          //color: Colors.grey[200],
          color: const Color(0xffDEF1EB),
        ),
        child: Row(
          children: [
            // Imagem do documento
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ImagemViewPage(documento: widget.document),
                ),
              ),
              child: Image.asset('assets/images/icon_doc.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOME
                Row(
                  children: [
                    const Text(
                      'Nome: ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(widget.document.nome!),
                  ],
                ),
                const SizedBox(height: 8),
                // MÊS
                Row(
                  children: [
                    const Text(
                      'Competência: ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text('$month/'),
                    Text('${widget.document.dataCompetencia?.year}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Categoria: ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(widget.categoria.nome),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 20),
            // MENU EDIT E REMOVE
            Expanded(
              child: Column(
                children: [
                  //Text('Menu'),
                  createPopupMenuButton(),
                ],
              ),
            )
          ],
        ),
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
              //chamar cadastrarDocumento passando o documento
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
