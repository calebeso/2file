import 'package:flutter/material.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/pages/imagemViewPage.dart';
import '../models/documento.dart';
import '../models/notificacao.dart';

class NotificacaoPage extends StatefulWidget {
  const NotificacaoPage({super.key});

  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  final NotifyDbHelper notifyDbHelper = NotifyDbHelper();
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();

  @override
  void initState() {
    super.initState();
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Notificações excluídas com sucesso!"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Color(0xffFE7C3F),
                      ));
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
      body: Container(
        color: const Color(0xffDEF1EB),
        child: Center(
          child: FutureBuilder<List<Notificacao>>(
            future: notifyDbHelper.listaNotificacoes(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Notificacao>> snapshot,
            ) {
              return snapshot.data!.isEmpty
                  ? Center(
                      child: Text(
                        'Lista de notificações vazia',
                        style: TextStyle(
                          fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                        ),
                      ),
                    )
                  : ListView(
                      children: snapshot.data!.map((notify) {
                        return Center(
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  trailing: const Icon(
                                    Icons.document_scanner,
                                    color: Color(0xffFE7C3F),
                                    size: 35,
                                  ),
                                  dense: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  title: Text(
                                    notify.body!,
                                    style: TextStyle(
                                      fontSize: 15 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                    ),
                                  ),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ImagemViewPage(
                                                  id_documento:
                                                      notify.id_documento!))),
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
                                              notifyDbHelper.removeNotificacao(
                                                  notify.id!);
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Notificação excluída com sucesso!"),
                                              duration: Duration(seconds: 2),
                                              backgroundColor:
                                                  Color(0xffFE7C3F),
                                            ));
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
                            ),
                          ),
                        );
                      }).toList(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
