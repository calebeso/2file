import 'package:flutter/material.dart';

import '../database/database_config.dart';
import '../models/documento.dart';
import 'Cadastrar_documentoPage.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Nome da Categoria'),
      ),
      body: Center(
        child: FutureBuilder<List<Documento>>(
          future: DatabaseHelper.instance.listDocumentos(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Documento>> snapshot) {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('Lista de documentos vazia.'),
                  )
                : ListView(
                    children: snapshot.data!.map((document) {
                      return Center(
                        child: Card(
                          color: const Color(0xffDEF1EB),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                leading: Image.asset(
                                    'assets/images/icon_doc.png',
                                    height: 60),
                                title: Text(
                                  document.nome,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Competência: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${document.nome}.',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      const TextSpan(
                                          text: '\nValidade: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      TextSpan(
                                        text: ' ${document.nome}.',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ]),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  child: const Icon(Icons.more_vert),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SimpleDialog(
                                            children: [
                                              SimpleDialogOption(
                                                onPressed: (() {
                                                  setState(() {
                                                    DatabaseHelper.instance
                                                        .removeDocumento(
                                                            document.id!);
                                                  });

                                                  Navigator.pop(context);
                                                }),
                                                child: const Text('Excluir'),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SimpleDialogOption(
                                                onPressed: (() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const CadastrarDocumentoPage()));
                                                }),
                                                child: const Text('Editar'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                                isThreeLine: false,
                                onTap: () {
                                  //chamar função para abrir view documento
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
          },
        ),
      ),
    );
  }
}
