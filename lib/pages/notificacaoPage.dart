import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/database_config.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/services/notificacaoService.dart';
import '../models/categoria.dart';
import '../models/documento.dart';
import 'package:intl/intl.dart';

import '../models/notificacao.dart';

class NotificacaoPage extends StatefulWidget {
  NotificacaoPage({super.key});

  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  final NotifyDbHelper notifyDbHelper = NotifyDbHelper();
  final NotificationService notificationService = NotificationService();
  Documento? documento;

  Future<String> textoNotificacao(int id) async {
    DocumentoDbHelper documentoDbHelper = DocumentoDbHelper();
    Documento documento = await documentoDbHelper.getDocumentoById(id);
    String texto =
        "O documento ${documento.nome} venceu em ${DateFormat("dd/MM/yyyy").format(documento.dataValidade!)}";
    return texto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Notificações'),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 5.0,
                title: const Text(
                    "Deseja realmente excluir todas as notificações?"),
                actions: [
                  MaterialButton(
                    child: const Text("Sim"),
                    onPressed: () {
                      setState(() {
                        notifyDbHelper.removerTodasNotificacoes();
                      });
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
            ),
            icon: const Icon(
              Icons.delete,
              color: Color(0xffFE7C3F),
            ),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Notificacao>>(
          future: notifyDbHelper.listaNotificacoes(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Notificacao>> snapshot,
          ) {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text(
                      'Lista de notificações vazia',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView(
                    children: snapshot.data!.map((notify) {
                      return Center(
                        child: Card(
                          color: const Color(0xffDEF1EB),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onLongPress: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          elevation: 5.0,
                                          title: const Text(
                                              "Deseja excluir esta notificação definitivamente?"),
                                          actions: [
                                            MaterialButton(
                                              child: const Text("Sim"),
                                              onPressed: () {
                                                setState(() {
                                                  notifyDbHelper
                                                      .removeNotificacao(
                                                          notify.id!);
                                                });
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
                                      ),
                                      //inserir aqui o texto com o nome do documento para a noitificação.
                                      child: Text(
                                        textoNotificacao(notify.id_documento!)
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onDoubleTap: () {
                                        return print('teste');
                                      },
                                      /*chamar função para vizualizar documento*/
                                      child: const Icon(
                                        Icons.document_scanner,
                                        color: Color(0xffFE7C3F),
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
