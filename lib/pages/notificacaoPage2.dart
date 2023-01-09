import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/database_config.dart';
import '../models/categoria.dart';
import '../models/documento.dart';
import 'package:intl/intl.dart';

import '../models/notificacoes.dart';

class NotificacaoPage2 extends StatefulWidget {
  const NotificacaoPage2({super.key});

  @override
  State<NotificacaoPage2> createState() => _NotificacaoPage2State();
}

class _NotificacaoPage2State extends State<NotificacaoPage2> {

  List<Notificacao> _listNotificacao = [];
  NotifyDbHelper _notifyDbHelper = NotifyDbHelper();

  void initiState(){
    super.initState();
    _atualizarListaNotificacao();
  }

  void dispose(){
    super.dispose();
  }

  _atualizarListaNotificacao() async{
    List<Notificacao> notifys = await _notifyDbHelper.listaNotificacoes();
    setState(() {
      _listNotificacao = notifys;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Notificações'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _listaDeNotificacoes(),
        ],
      )
    );
  }

  _listaDeNotificacoes(){

    return _listNotificacao.isEmpty ? const Center(
      child: Text(
        'Lista de notificações vazia',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ):Expanded(
        child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount:_listNotificacao.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      child: ListTile(
                        title: Text(_listNotificacao[index].title.toString()),
                        trailing: const Icon(
                          Icons.document_scanner, color: Color(0xffFE7C3F),
                          size: 35,),
                      ),
                      onLongPress: () => showDialog(
                         context: context,
                         builder: (context) => AlertDialog(
                               elevation: 5.0,
                               title: const Text("Deseja excluir esta notificação definitivamente?"),
                               actions: [
                                    MaterialButton(
                                        child: const Text("Sim"),
                                        onPressed: () {
                                            setState(() {
                                            _notifyDbHelper.removeNotificacao(_listNotificacao[index].id!);
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
                    ),
                  ],
                );
              },

            ),
          )
       ),
    );
  }
}
