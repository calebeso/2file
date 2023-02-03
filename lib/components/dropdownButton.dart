import 'package:flutter/material.dart';
import 'package:to_file/components/elementListView.dart';
import 'package:to_file/databases/categoriaDbHelper.dart';

import '../databases/documentoDbHelper.dart';
import '../models/categoria.dart';
import '../models/documento.dart';

class DropdownButtonPesquisa extends StatefulWidget {
  const DropdownButtonPesquisa({required this.nameDocumentController});

  final TextEditingController nameDocumentController;

  @override
  State<DropdownButtonPesquisa> createState() => _DropdownButtonPesquisaState();
}

class _DropdownButtonPesquisaState extends State<DropdownButtonPesquisa> {
  DocumentoDbHelper documentoDbHelper = DocumentoDbHelper();
  CategoriaDbHelper categoriaDbHelper = CategoriaDbHelper();

  List<Documento> documents = [];
  List<Documento> documentsFiltered = [];
  List<Categoria> categories = [];
  List<Map<String, dynamic>> dropdownMonthList = [];
  List<int> listYears = [];

  // dropDownButtons
  int? _dropDownValueMonth;
  int? _dropDownValueYear;
  int? _dropDownValueCategory;
  final GlobalKey<FormFieldState> _keyDropdownMonth = GlobalKey();
  final GlobalKey<FormFieldState> _keyDropdownYear = GlobalKey();
  final GlobalKey<FormFieldState> _keyDropdownCategory = GlobalKey();

  _addToList(dynamic list, var element) {
    if (!list.contains(element)) {
      list.add(element);
    }
  }

  // buscar dados de documentos - BD
  getDocumentsDb() async {
    List<Documento> doc = await documentoDbHelper.listDocumentos();
    List<int> months = [];
    List<int> years = [];
    List<int> categoriesId = [];

    documents.forEach((documento) {
      var month = documento.dataCompetencia?.month;
      var year = documento.dataCompetencia?.year;
      var category = documento.categoria_id;
      _addToList(months, month);
      _addToList(years, year);
      _addToList(categoriesId, category);
    });

    List<Categoria> cats =
        await categoriaDbHelper.getCategoriesByListId(categoriesId);

    setState(() {
      documents = doc;
      dropdownMonthList = listMonth
          .where((element) => months.contains(element["value"]))
          .toList();
      listYears = years;
      years.sort();
      categories = cats;
      cats.sort((a, b) => a.nome.compareTo(b.nome));
    });
    searchDocuments();
  }

  final List<Map<String, dynamic>> listMonth = [
    {"month": "Janeiro", "value": 1},
    {"month": "Fevereiro", "value": 2},
    {"month": "Março", "value": 3},
    {"month": "Abril", "value": 4},
    {"month": "Maio", "value": 5},
    {"month": "Junho", "value": 6},
    {"month": "Julho", "value": 7},
    {"month": "Agosto", "value": 8},
    {"month": "Setembro", "value": 9},
    {"month": "Outubro", "value": 10},
    {"month": "Novembro", "value": 11},
    {"month": "Dezembro", "value": 12},
  ];

  @override
  Widget build(BuildContext context) {
    getDocumentsDb();
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createDropdownMonth(),
              const SizedBox(width: 10),
              createDropdownYear(),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createDropdownCategory(),
            ],
          ),
          const SizedBox(height: 20),
          createListViewDocument(),
        ],
      ),
    );
  }

  createDropdownMonth() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DropdownButtonFormField<int>(
          decoration: InputDecoration(
            hintText: 'Mês',
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                _dropDownValueMonth = null;
                _keyDropdownMonth.currentState?.reset();
              },
            ),
          ),
          key: _keyDropdownMonth,
          value: null,
          isExpanded: true,
          onChanged: (int? value) {
            _dropDownValueMonth = value;
          },
          items: [
            for (var month in dropdownMonthList) ...[
              DropdownMenuItem(
                value: month["value"],
                child: Text(month["month"]),
              )
            ]
          ],
        ),
      ),
    );
  }

  createDropdownYear() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              hintText: 'Ano',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  _dropDownValueYear = null;
                  _keyDropdownYear.currentState?.reset();
                },
              ),
            ),
            key: _keyDropdownYear,
            value: _dropDownValueYear,
            onChanged: (int? value) {
              _dropDownValueYear = value;
            },
            isExpanded: true,
            items: listYears.map<DropdownMenuItem<int>>((selectedValue) {
              return DropdownMenuItem(
                value: selectedValue,
                child: Text('$selectedValue'),
              );
            }).toList()),
      ),
    );
  }

  createDropdownCategory() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              hintText: 'Categoria',
              suffixIcon: IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  _dropDownValueCategory = null;
                  _keyDropdownCategory.currentState?.reset();
                },
              ),
            ),
            value: _dropDownValueCategory,
            onChanged: (int? value) {
              _dropDownValueCategory = value;
            },
            isExpanded: true,
            items: categories.map<DropdownMenuItem<int>>((category) {
              return DropdownMenuItem(
                value: category.id,
                child: Text(category.nome),
              );
            }).toList()),
      ),
    );
  }

  // createSearchButton() {
  //   return SizedBox(
  //     width: 310,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         searchDocuments();
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xffDFDDC7),
  //         //padding: const EdgeInsets.all(5),
  //       ),
  //       child: const Icon(
  //         Icons.search,
  //         size: 30,
  //         color: Color(0xffFE7C3F),
  //       ),
  //     ),
  //   );
  // }

  createListViewDocument() {
    return Expanded(
      child: ListView(
        //shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          for (Documento doc in documentsFiltered)
            ElementListView(
              document: doc,
              listMonth: listMonth,
              categoria: categories.isEmpty
                  ? Categoria(
                      id: -1,
                      nome: 'carregando...',
                      nomeIcone: '',
                      criadoEm: DateTime.now())
                  : categories.where((cat) => cat.id == doc.categoria_id).first,
            ),
        ],
      ),
    );
  }

  void searchDocuments() {
    setState(() {
      documentsFiltered = documents.isEmpty
          ? []
          : documents
              .where((doc) =>
                  (doc.nome!.contains(widget.nameDocumentController.text) ||
                      widget.nameDocumentController.text == "") &&
                  (doc.dataCompetencia?.month == _dropDownValueMonth ||
                      _dropDownValueMonth == null) &&
                  (doc.dataCompetencia?.year == _dropDownValueYear ||
                      _dropDownValueYear == null) &&
                  (doc.categoria_id == _dropDownValueCategory ||
                      _dropDownValueCategory == null))
              .toList();
    });
  }
}
