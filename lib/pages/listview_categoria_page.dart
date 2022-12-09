import '../models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:to_file/models/categoria.dart';

import '../components/categoriaList.dart';
import '../models/documento.dart';

class CategoriaListPage extends StatefulWidget {
  @override
  State<CategoriaListPage> createState() => _CategoriaListPageState();
}

class _CategoriaListPageState extends State<CategoriaListPage> {
  late final List<Documento> _documentosList = [
    Documento(
      id: 1,
      nome: 'Carta',
      criadoEm: DateTime.now(),
    ),
    Documento(id: 2, nome: 'Memorando', criadoEm: DateTime.now()),
    Documento(id: 3, nome: 'Paper', criadoEm: DateTime.now()),
    Documento(id: 4, nome: 'Artigo', criadoEm: DateTime.now()),
    Documento(id: 5, nome: 'TCC', criadoEm: DateTime.now()),
    Documento(id: 6, nome: 'oficio', criadoEm: DateTime.now()),
    Documento(id: 7, nome: 'nota fiscal', criadoEm: DateTime.now()),
  ];

  late final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("2File"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Categoria',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CategoriaList(_documentosList)
          ],
        ));
  }
}
