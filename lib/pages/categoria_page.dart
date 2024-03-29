import 'dart:io';

import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/pages/documentos/edit_documento_page.dart';
import '../models/documento.dart';
import 'package:intl/intl.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/categoria.dart';
import 'package:to_file/pages/imagemViewPage.dart';
import 'package:path/path.dart';
import '../models/documento.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({required this.categoria});

  final Categoria categoria;

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();
  List<Documento> documentos = [];
  String nomeCategoria = '';

  late Future<List<Documento>> _documentosLista;

  @override
  void initState() {
    super.initState();
    _atualizarNomeCategoria();
    _atualizarListaDocumentos();
  }

  _atualizarListaDocumentos() {
    setState(() {
      _documentosLista =
          _documentoDbHelper.listDocumentosByCategoriaId(widget.categoria.id!);
    });
  }

  _atualizarNomeCategoria() {
    setState(() {
      nomeCategoria = widget.categoria.nome;
    });
  }

  int? seletctedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Text(nomeCategoria),
      ),
      body: Center(
        child: FutureBuilder<List<Documento>>(
          future: _documentosLista,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.map((document) {
                  return Center(
                    child: GestureDetector(
                      child: Card(
                        color: const Color(0xffDEF1EB),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 5),
                              leading: Image.asset('assets/images/icon_doc.png',
                                  height: 60),
                              title: Text(
                                document.nome,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
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
                                      text:
                                          ' ${DateFormat(DateFormat.YEAR_MONTH, 'pt-Br').format(document.dataCompetencia)}.',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    const TextSpan(
                                        text: '\nValidade: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    TextSpan(
                                      text:
                                          ' ${DateFormat('dd/MM/yyyy').format(document.dataValidade)}.',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    const TextSpan(
                                        text: '\nCriado em: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    TextSpan(
                                      text:
                                          ' ${DateFormat('dd/MM/yyyy KK:mm').format(document.criadoEm)}',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ]),
                                ),
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem<_ValueDialog>(
                                    value: _ValueDialog.editar,
                                    child: Text("Editar"),
                                  ),
                                  const PopupMenuItem(
                                    value: _ValueDialog.excluir,
                                    child: Text('Excluir'),
                                  ),
                                ],
                                onSelected: (value) {
                                  switch (value) {
                                    case _ValueDialog.editar:
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EditDocumentoPage(
                                                      documento: document)));
                                      break;
                                    case _ValueDialog.excluir:
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          elevation: 5.0,
                                          title: Text(
                                              "Deseja excluir ${document.nome} definitivamente?"),
                                          actions: [
                                            MaterialButton(
                                              child: const Text("Sim"),
                                              onPressed: () {
                                                setState(() {
                                                  _documentoDbHelper
                                                      .removeDocumento(
                                                          document.id!);
                                                  _atualizarListaDocumentos();
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Documento excluído com sucesso!"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundColor:
                                                      Color(0xffFE7C3F),
                                                ));
                                                _excluirNotificacao(
                                                    document.id!);
                                                _deletarImagem(
                                                    document.nome_imagem);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            MaterialButton(
                                              child: const Text('Não'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                      break;
                                  }
                                },
                              ),
                              isThreeLine: false,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ImagemViewPage(
                                                id_documento: document.id!)));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

enum _ValueDialog {
  editar,
  excluir,
}

_excluirNotificacao(int id_documento) async {
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  await _notifyDbHelper.removerNotificacaoByIdDocumento(id_documento);
}

_deletarImagem(String nomeImagem) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, nomeImagem);
  bool isExist = await File(path).exists();
  if (isExist) {
    await File(path).delete();
  }
}
