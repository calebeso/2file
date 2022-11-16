import 'package:first_app/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/documento.dart';

class CategoriaList extends StatelessWidget {
  late final List<Documento> documentosList;
  late final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: documentosList.length,
        itemBuilder: (ctx, index) {
          final doc = documentosList[index];
          return Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  color: Colors.deepOrange[100],
                  child: Column(
                    children: [
                      Text(
                        'Nome: ${doc.nome.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                      Text(
                        'Competência: ${doc.dataCompetencia.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                      Text(
                        'Validade: ${DateFormat('d MMM y').format(doc.dataCompetencia!)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => print('abrir documento'),
                  child: Column(
                    children: [
                      Container(
                          //mostrar imagem/icone  de documento conforme modelo.
                          ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => print("editar e excluir"),
                  child: Column(
                    children: [
                      //criar botões para acesso a excluir e editar (modal)
                    ],
                  ),
                )
              ], //children end
            ),
          );
        },
      ),
    );
  }
}
