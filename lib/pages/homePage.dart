import 'package:flutter/material.dart';
import 'package:to_file/components/cardAddCategoria.dart';
import 'package:to_file/components/cardCategoria.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/pages/documentoPage.dart';
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

  // pesquisa de documento
  final _formKey = GlobalKey<FormState>();
  final _nomeDocumento = TextEditingController();

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          pesquisarNomeDocumento(),

          // IF ==> TextForm nomeDocumento estiver vazio - mostrar GridViewCards
          criarGridViewCards(),

          // Flexible(flex: 1, child: Container()),

          // ELSE ==> mostrar demais TextForm, tornar GridView invisible
          mostrarCamposPesquisa(),
        ],
      ),

      // ADICIONAR DOCUMENTO

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

  pesquisarNomeDocumento() {
    return Flexible(
      child: Container(
        height: 100,
        color: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Expanded(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeDocumento,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  criarGridViewCards() {
    return Flexible(
      child: Container(
        color: Colors.yellow,
        child: GridView.count(
            crossAxisCount: 3,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              CardAddCategoria(
                  atualizarListaCategorias: atualizarListaCategorias()),
              for (var cat in _categorias) ...[CardCategoria(categoria: cat)],
            ]),
      ),
    );
  }

  mostrarCamposPesquisa() {
    return Flexible(
      child: Container(),
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
