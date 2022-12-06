import 'package:flutter/material.dart';

import '../database/database_config.dart';
import '../models/notificacao.dart';

class Notificacoes extends StatefulWidget {
  const Notificacoes({super.key});

  @override
  State<Notificacoes> createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notificações'),
        ),
        body: Center(
          child: FutureBuilder<List<Notificacao>>(
              future: DatabaseHelper.instance.listNotificacoes(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Notificacao>> snapshot) {
                return snapshot.data!.isEmpty
                    ? const Center(
                        child: Text('Lista de notificações vazia.'),
                      )
                    : ListView(
                        children: snapshot.data!.map((notify) {
                          return Center(
                            child: Card(
                              color: const Color(0xffDEF1EB),
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.all(10.0),
                                    subtitle: const Text(
                                      'O documento x venceu hoje  - data - ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    isThreeLine: true,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
              }),
        ));
  }
}
