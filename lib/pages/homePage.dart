import 'package:flutter/material.dart';
import 'package:to_file/components/cardCategoria.dart';
import 'package:to_file/pages/documentoPage.dart';
import 'package:to_file/pages/pesquisaPage.dart';
import 'package:to_file/pages/sobrePage.dart';

import '../models/categoria.dart';
import 'newCategoriaPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? textController;

  // final DatabaseHelper dbHelper = DatabaseHelper.instance;

  List<dynamic> categorias = [
    Categoria(
        id: 0,
        nome: 'Recibo',
        nomeIcone: 'recibo.png',
        criadoEm: DateTime.now()),
    Categoria(
        id: 1,
        nome: 'Fatura',
        nomeIcone: 'fatura.png',
        criadoEm: DateTime.now()),
    Categoria(
        id: 2,
        nome: 'Extrato Bancário',
        nomeIcone: 'extrato-bancario.png',
        criadoEm: DateTime.now()),
    Categoria(
        id: 3,
        nome: 'Nota Fiscal',
        nomeIcone: 'notaFiscal.png',
        criadoEm: DateTime.now()),
    Categoria(
        id: 4,
        nome: 'Contrato',
        nomeIcone: 'contrato.png',
        criadoEm: DateTime.now()),
    Categoria(
        id: 5,
        nome: 'Boleto',
        nomeIcone: 'boleto.png',
        criadoEm: DateTime.now()),
    Categoria(
        id: 6,
        nome: 'Pessoal',
        nomeIcone: 'pessoal.png',
        criadoEm: DateTime.now())
  ];

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
          const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.notifications,
                color: Color(0xffFE7C3F),
              ))
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
              onPressed: () {
                setState(() {
                  pageSearch();
                });
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
          Container(
            height: 500.0,
            // child: FutureBuilder<List<Categoria>>(
            //   future: DatabaseHelper.instance.listCategoriaById(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<List<Categoria>> snapshot) {
            //     if (snapshot.hasData) {
            //       return GridView.count(
            //         crossAxisCount: 3,
            //         primary: false,
            //         padding: const EdgeInsets.all(20),
            //         crossAxisSpacing: 10,
            //         mainAxisSpacing: 10,
            //         children:
            //             //  buscar categorias do banco de dados
            //             // for (var cat in categorias)...[
            //             //   CardCategoria(categoria: cat)
            //             // ],
            //             snapshot.data!.map((cat) {
            //           return CardCategoria(categoria: cat);
            //         }).toList(),
            //
            //         // Card ADD NEWCategoriaPage
            //       );
            //     } else {}
            //   },
            child: GridView.count(
              crossAxisCount: 3,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                for (var cat in categorias) ...[CardCategoria(categoria: cat)],
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                NewCategoriaPage()));
                  },
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    padding: const EdgeInsets.all(8),
                    // color: const Color(0xffEAEBD9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 3.0,
                          offset: Offset(0.0, 0.80),
                        ),
                      ],
                    ),
                    child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.add,
                          color: Color(0xffFE7C3F),
                          size: 40,
                        )),
                  ),
                ),
              ],
            ),
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
