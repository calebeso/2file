import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/categoria.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/pages/documentos/edit_documento_page.dart';
import 'package:to_file/pages/imagemViewPage.dart';

class CategoriaPage2 extends StatefulWidget {
  const CategoriaPage2({super.key, required this.categoria});

  final Categoria categoria;

  @override
  State<CategoriaPage2> createState() => _EstoqueState();
}

class _EstoqueState extends State<CategoriaPage2> {
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();
  List<Documento> _documentosLista = [];

  _atualizarListaDocumentos() async {
    List<Documento> documentos = await _documentoDbHelper
        .listDocumentosByCategoriaId(widget.categoria.id!);
    setState(() {
      _documentosLista = documentos;
    });
  }

  @override
  void initState() {
    super.initState();
    _atualizarListaDocumentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0C322C),
          title: Text(widget.categoria.nome),
        ),
        body: _documentosLista.isNotEmpty
            ? Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: _documentosLista.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      color: const Color(0xffDEF1EB),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 5),
                            leading: Image.asset('assets/images/icon_doc.png',
                                height: 60),
                            title: Text(
                              _documentosLista[index].nome,
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
                                        ' ${DateFormat(DateFormat.YEAR_MONTH, 'pt-Br').format(_documentosLista[index].dataCompetencia)}.',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const TextSpan(
                                      text: '\nValidade: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  TextSpan(
                                    text:
                                        ' ${DateFormat('dd/MM/yyyy').format(_documentosLista[index].dataValidade)}.',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const TextSpan(
                                      text: '\nCriado em: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  TextSpan(
                                    text:
                                        ' ${DateFormat('dd/MM/yyyy KK:mm').format(_documentosLista[index].criadoEm)}',
                                    style: const TextStyle(color: Colors.black),
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
                                                    documento: _documentosLista[
                                                        index])));
                                    break;
                                  case _ValueDialog.excluir:
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        elevation: 5.0,
                                        title: Text(
                                            "Deseja excluir ${_documentosLista[index].nome} definitivamente?"),
                                        actions: [
                                          MaterialButton(
                                            child: const Text("Sim"),
                                            onPressed: () {
                                              setState(() {
                                                _documentoDbHelper
                                                    .removeDocumento(
                                                        _documentosLista[index]
                                                            .id!);
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
                                                ),
                                              );
                                              _excluirNotificacao(
                                                  _documentosLista[index].id!);
                                              _deletarImagem(
                                                  _atualizarListaDocumentos()[
                                                          index]
                                                      .nome_imagem);
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
                                          id_documento:
                                              _documentosLista[index].id!),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              )
            : Container(
                color: const Color(0xffC1E7DA),
                child: const Center(
                  child: Text(
                    "Lista de documentos vazia.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ));
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
