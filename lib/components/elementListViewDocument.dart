import 'package:flutter/material.dart';

import '../models/documento.dart';

class ElementListView extends StatefulWidget {
  const ElementListView(
      {super.key, required this.document, required this.listMonth});

  final Documento document;
  final List<Map<String, dynamic>> listMonth;

  @override
  State<ElementListView> createState() => _ElementListViewState();
}

class _ElementListViewState extends State<ElementListView> {
  @override
  Widget build(BuildContext context) {
    final String month = widget.listMonth
        .where((element) =>
            element["value"] == widget.document.dataCompetencia?.month)
        .first['month'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          //color: Colors.grey[200],
          color: const Color(0xffDEF1EB),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/icon_doc.png'),
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
                        Text('${widget.document.categoria_id}'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
