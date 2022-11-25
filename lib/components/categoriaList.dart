import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/documento.dart';

class CategoriaList extends StatelessWidget {
  final List<Documento> documentos;

  //constructor

  CategoriaList(this.documentos);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: ListView.builder(
        itemCount: documentos.length,
        itemBuilder: (ctx, index) {
          final doc = documentos[index];
          return Card(
            color: const Color(0xffDEF1EB),
            shadowColor: const Color(0xffFE7C3F),
            margin: const EdgeInsets.all(5),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print('Teste');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      'assets/images/icon_doc.png',
                      height: 55,
                    ),
                  ),
                ),
                Container(
                  width: 220,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Nome: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            doc.id.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Competência: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            DateFormat('d/MMM/y.')
                                .format(doc.criadoEm!)
                                .toString(),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Criado em:  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            DateFormat('d/MMM/y.')
                                .format(doc.criadoEm!)
                                .toString(),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Categoria: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            doc.nome!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Colors.amber,
                        size: 30.0,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),
              ], //children end
            ),
          );
        },
      ),
    );
  }
}
