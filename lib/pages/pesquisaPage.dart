import 'package:flutter/material.dart';

import '../databases/documentoDbHelper.dart';
import '../models/documento.dart';

class PesquisaPage extends StatefulWidget {
  const PesquisaPage({Key? key}) : super(key: key);

  @override
  State<PesquisaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<PesquisaPage> {

  DocumentoDbHelper documentoDbHelper = DocumentoDbHelper();

  List<Documento> documents = [];
  List months = [];
  List years = [];

  getDocumentsDb() async {
    List<Documento> doc = await documentoDbHelper.listDocumentos();
    getMonthDocument(doc);
    setState(() {
      documents = doc;
    });
  }

  getMonthDocument(List<Documento> doc) async {
    documents.forEach((documento) {
      setState(() {
        var month = documento.dataCompetencia?.month;
        months.add(month!);
        // aplicar filter
      });
    });
  }

  getYearDocument(List<Documento> doc) async {
    documents.forEach((documento) {
      setState(() {
        var year = documento.dataCompetencia?.year;
        years.add(year!);
        // aplicar filter
      });
    });
  }

  final valorDropdown = ValueNotifier('');
  final List<String> dropdownListaMeses = [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          create_dropdownsButtons(),
          //buscarMesCompetencia(),
        ],
      ),
    );
  }

  create_dropdownsButtons() {
    return Container(
      margin: const EdgeInsets.all(30),
      //color: Colors.orange,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // MÊS
              ValueListenableBuilder(
                  valueListenable: valorDropdown,
                  builder: (BuildContext context, String value, _) {
                    return DropdownButton<String>(
                      icon: const Icon(Icons.calendar_month),
                      hint: const Text('Mês'),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (opcao) =>
                          valorDropdown.value = opcao.toString(),
                      items: dropdownListaMeses
                          .map(
                            (opcao) => DropdownMenuItem(
                              child: Text(opcao),
                              value: opcao,
                            ),
                          )
                          .toList(),
                    );
                  }),

              // ANO
              ValueListenableBuilder(
                  valueListenable: valorDropdown,
                  builder: (BuildContext context, String value, _) {
                    return DropdownButton<String>(
                      icon: const Icon(Icons.calendar_today),
                      hint: const Text('Ano'),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (opcao) =>
                          valorDropdown.value = opcao.toString(),
                      items: dropdownListaMeses
                          .map(
                            (opcao) => DropdownMenuItem(
                              child: Text(opcao),
                              value: opcao,
                            ),
                          )
                          .toList(),
                    );
                  }),

              // CATEGORIA
              // ValueListenableBuilder(
              //     valueListenable: valorDropdown,
              //     builder: (BuildContext context, String value, _) {
              //       return DropdownButton<String>(
              //         hint: const Text('categoria'),
              //         value: (value.isEmpty) ? null : value,
              //         onChanged: (opcao) => valorDropdown.value = opcao.toString(),
              //         items: dropdownListaMeses
              //             .map(
              //               (opcao) => DropdownMenuItem(
              //                 child: Text(opcao),
              //                 value: opcao,
              //               ),
              //             )
              //             .toList(),
              //       );
              //     }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //CATEGORIA
              ValueListenableBuilder(
                  valueListenable: valorDropdown,
                  builder: (BuildContext context, String value, _) {
                    return DropdownButton<String>(
                      icon: const Icon(Icons.list),
                      hint: const Text('Categoria'),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (opcao) =>
                          valorDropdown.value = opcao.toString(),
                      items: dropdownListaMeses
                          .map(
                            (opcao) => DropdownMenuItem(
                              child: Text(opcao),
                              value: opcao,
                            ),
                          )
                          .toList(),
                    );
                  }),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFE7C3F),
                    padding: const EdgeInsets.all(0.8)),
                child: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
