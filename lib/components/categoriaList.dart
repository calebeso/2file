import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/documento.dart';

class CategoriaList extends StatelessWidget {

  final List<Documento> documentos;

  //constructor
  CategoriaList(this.documentos);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(

    child: Container(
      height: 480,
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
                Container(
                  padding: EdgeInsets.all(5),
                  margin: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xff000000),
                        width: 2,
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Id: ${doc.id.toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        'Nome: ${doc.nome}.',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        'Criado em: ${DateFormat('d/MMM/y.').format(doc.criadoEm!).toString()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
                          child: Image.asset('assets/images/icon_doc.png', height: 55,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 2,
                            )
                        ),
                        margin: const EdgeInsets.only(
                          left: 50
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => print('excluir ou editar documento'),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset('assets/images/reticencias_vert.png', height: 55,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 2,
                            )
                        ),
                        margin: const EdgeInsets.only(
                            left: 20
                        ),
                      ),
                    ],
                  ),
                ),
              ], //children end
            ),
          );
        },
      ),
    ),
    );
  }
}
