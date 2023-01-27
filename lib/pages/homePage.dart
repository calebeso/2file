import 'package:flutter/material.dart';
import 'package:to_file/components/cardAddCategoria.dart';
import 'package:to_file/components/cardCategoria.dart';
import 'package:to_file/components/dropdownButton.dart';
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/pages/documentoPage.dart';
import 'package:to_file/pages/notificacaoPage.dart';
import 'package:to_file/pages/sobrePage.dart';

import '../databases/categoriaDbHelper.dart';
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
  TextEditingController nameDocumentController = TextEditingController();

  List<Categoria> _categorias = [];
  final DatabaseHelper dbConfig = DatabaseHelper.instance;

  var showGrid = true;
  final NotificationService notificationService = NotificationService();
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();

  int count = 0;

  CategoriaDbHelper categoriaCrud = CategoriaDbHelper();

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
    List<Categoria> cat = await dbConfig.listCategoriaById();
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

      // CONTEÚDO DA TELA
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 50,
                child: TextField(
                  controller: nameDocumentController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Digite o nome do documento',
                    hintText: 'Ex: Contrato',
                    suffixIcon: IconButton(
                      onPressed: () {
                        nameDocumentController.clear();
                      },
                      icon: Icon(
                        nameDocumentController.text == ''
                            ? Icons.search
                            : Icons.clear,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    // ocultar gridView
                    showGrid = !showGrid;
                  },
                ),
              ),
              // const SizedBox(width: 8),
              //
              // Visibility(
              //   visible: !showGrid,
              //   child: createReturnButton(),
              // ),

              Visibility(
                visible: showGrid,
                child: criarGridViewCards(),
              ),
              Visibility(
                visible: !showGrid,
                child: DropdownButtonPesquisa(
                    nameDocumentController: nameDocumentController),
              ),
            ],
          ),
        ),
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

  // createReturnButton() {
  //   return IconButton(
  //     onPressed: () {
  //       setState(() {
  //         Visibility(
  //           visible: showGrid,
  //           child: criarGridViewCards(),
  //         );
  //       });
  //     },
  //     icon: const Icon(
  //       Icons.keyboard_return,
  //       size: 30,
  //     ),
  //   );
  // }

  criarGridViewCards() {
    return Flexible(
      child: Container(
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

  // createReturnButton() {
  //   return ElevatedButton(
  //       onPressed: (){
  //         showGrid;
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xff30BA78),
  //       ),
  //       child:  const Icon(
  //           Icons.keyboard_return,
  //           size: 30,
  //           color:  Colors.white,
  //       ),
  //   );
  // }

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
}
