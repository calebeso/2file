import 'package:flutter/material.dart';
import 'package:to_file/components/cardAddCategoria.dart';
import 'package:to_file/components/cardCategoria.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/pages/documentos/documento_page.dart';
import 'package:to_file/pages/notificacaoPage.dart';
import 'package:to_file/pages/pesquisaPage.dart';
import 'package:to_file/pages/sobrePage.dart';

import '../databases/categoria_crud.dart';
import '../databases/database_config.dart';
import '../models/categoria.dart';
import '../models/notificacao.dart';
import '../services/notificacaoService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? textController;
  List<Categoria> _categorias = [];
  final DatabaseHelper dbConfig = DatabaseHelper.instance;

  final NotificationService notificationService = NotificationService();
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();

  int count = 0;

  CategoriaCrud categoriaCrud = CategoriaCrud();

  @override
  void initState() {
    notificationService.initializeNotifications();
    notificationService.mostrarNotificacoes();
    super.initState();
    atualizarListaCategorias();
    atualizarContador();
  }

  atualizarContador() async {
    List<Notificacao> notifys = await _notifyDbHelper.listaNotificacoes();
    setState(() {
      count = notifys.length;
    });
  }

  atualizarListaCategorias() async {
    List<Categoria> cat = await categoriaCrud.listCategoriaById();
    setState(() {
      _categorias = cat;
      atualizarContador();
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NotificacaoPage()));
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
              onPressed: () => notificationService.showPushNotification(
                  id: 10, title: 'teste', body: 'teste'),
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
                    CardCategoria(
                        categoria: cat,
                        atualizarListaCategorias: atualizarListaCategorias())
                  ],
                ]),
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
