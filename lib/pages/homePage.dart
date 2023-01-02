import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_file/components/cardAddCategoria.dart';
import 'package:to_file/components/cardCategoria.dart';
import 'package:to_file/pages/documentoPage.dart';
import 'package:to_file/pages/pesquisaPage.dart';
import 'package:to_file/pages/sobrePage.dart';

import '../databases/database_config.dart';
import '../models/categoria.dart';
import '../models/notificacoes.dart';
import '../services/notificationService.dart';
import 'notificacaoPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? textController;

  List<Categoria> _categorias = [];
  final DatabaseHelper dbConfig = DatabaseHelper.instance;

  late final LocalNotificationService notificationService;

  int count = 0;

  @override
  void initState() {
    notificationService = LocalNotificationService();
    notificationService.initializeNotifications();
    super.initState();
    atualizarListaCategorias();
    atualizarContador();
    // notifyCount();
  }

  Future<void> atualizarContador() async {
    count = await notificationService.notifyCount();
  }

  atualizarListaCategorias() async {
    List<Categoria> cat = await dbConfig.listCategoriaById();
    setState(() {
      _categorias = cat;
      atualizarContador();
    });
  }

  addNotify() {
    setState(() {
      DatabaseHelper.instance
          .addNotificacao(Notificacao(criadoEm: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Image.asset(
          'assets/images/appbar.png',
          height: 100.0,
          width: 120.0,
          fit: BoxFit.cover,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                pageSobre();
              });
            },
            icon: const Icon(Icons.info, color: Color(0xffFE7C3F)),
          ),
          Stack(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              IconButton(
                onPressed: () {
                  addNotify();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const NotificacaoPage()));
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Color(0xffFE7C3F),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            height: 65,
            width: 350,
            // alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () async {
                await notificationService.showPushNotification(
                    id: 1, title: 'teste', body: 'notificacao');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'pesquisar',
                    style: TextStyle(
                      color: Color(0xffB9B1B1),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color(0xffB9B1B1),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            // height: MediaQuery.of(context).size.height,
            child: GridView.count(
                crossAxisCount: 3,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  CardAddCategoria(
                      atualizarListaCategorias: atualizarListaCategorias()),
                  for (var cat in _categorias) ...[
                    CardCategoria(categoria: cat)
                  ],
                ]),

            // child: FutureBuilder<List<Categoria>>(
            //   future: DatabaseHelper.instance.listCategoriaById(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<List<Categoria>> snapshot) {
            //     if (snapshot.hasData) {
            //       return GridView.count(
            //           crossAxisCount: 3,
            //           primary: false,
            //           padding: const EdgeInsets.all(20),
            //           crossAxisSpacing: 10,
            //           mainAxisSpacing: 10,
            //           children: [
            //             const CardAddCategoria(),
            //             for (var cat in snapshot.data!) ...[
            //               CardCategoria(categoria: cat)
            //             ],
            //           ]);
            //     } else {
            //       return const Text("");
            //     }
            //   },
            // ),
          ),
        ],
      ),

      // Botão de ação - adicionar documento
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            pageDocument();
          });
        },
        backgroundColor: const Color(0xff30BA78),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  void pageSobre() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const SobrePage()));
  }

  void pageDocument() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const DocumentoPage()));
  }

  void pageSearch() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const PesquisaPage()));
  }
}
