import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/database_config.dart';
import 'package:to_file/services/notificacaoService.dart';
import '../models/categoria.dart';
import '../models/documento.dart';
import 'package:intl/intl.dart';

import '../models/notificacao.dart';

class NotificacaoPage extends StatefulWidget {
  const NotificacaoPage({super.key});

  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Notificações'),
      ),
      body: Center(
        child: FutureBuilder<List<Notificacao>>(
          future: _notifyDbHelper.listaNotificacoes(),
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
                                          elevation: 5.0,
                                          title: const Text(
                                              "Deseja excluir esta notificação definitivamente?"),
                                          actions: [
                                            MaterialButton(
                                              child: const Text("Sim"),
                                              onPressed: () {
                                                setState(() {
                                                  _notifyDbHelper
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
                                      child: Text(
                                        'teste',
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
