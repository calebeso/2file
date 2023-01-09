import 'package:flutter/material.dart';
import 'package:to_file/models/categoria.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacoes.dart';
import 'package:to_file/pages/categoria_page.dart';
import 'package:to_file/pages/homePage.dart';

import '../databases/NotificacaoDbHelper.dart';
import '../databases/database_config.dart';

class DocumentoPage extends StatefulWidget {
  const DocumentoPage({Key? key}) : super(key: key);

  @override
  State<DocumentoPage> createState() => _DocumentoPageState();
}

class _DocumentoPageState extends State<DocumentoPage> {
  final _controllerNome = TextEditingController();
  final _controllerDataCompetencia = TextEditingController();
  final _controllerDataValidade = TextEditingController();
  NotifyDbHelper _notifyDbHelper = NotifyDbHelper();

  var _selectedValue;
  var _categorias = <DropdownMenuItem>[];

  DateTime? pickedDataCompetencia;
  DateTime? pickedDataValidade;
  DateTime? dataCompetenciaTimeStamp;
  DateTime? dataValidadeTimeStamp;

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  _loadCategorias() async {
    var categorias = await DatabaseHelper.instance.todasCategorias();
    categorias.forEach((element) {
      setState(() {
        _categorias.add(DropdownMenuItem(
          child: Text(element.nome),
          value: element.id,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xff0C322C),
          title: const Text('Adicionar documento'),
        ),
        body: ListView(padding: EdgeInsets.all(16), children: <Widget>[
          TextField(
            controller: _controllerNome,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Nome do Documento'),
          ),
          const SizedBox(height: 24),
          TextField(
              controller: _controllerDataCompetencia,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Data de Competência"),
              readOnly: true,
              onTap: () {
                _pickDateDialogCompetencia();
              }),
          const SizedBox(height: 24),
          TextField(
              controller: _controllerDataValidade,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Data de Validade"),
              readOnly: true,
              onTap: () {
                _pickDateDialogValidade();
              }),
          const SizedBox(height: 24),
          DropdownButtonFormField(
              hint: const Text('Selecione uma categoria'),
              value: _selectedValue,
              items: _categorias,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              }),
          const SizedBox(height: 32),
          ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () async {
                var now = DateTime.now();

                final documento = Documento(
                  nome: _controllerNome.text,
                  dataCompetencia: dataCompetenciaTimeStamp,
                  dataValidade: dataValidadeTimeStamp,
                  criadoEm: DateTime.fromMicrosecondsSinceEpoch(
                      now.microsecondsSinceEpoch),
                  categoria_id: _selectedValue,
                );

                setState(() {
                  DatabaseHelper.instance.addDocumento(documento);
                });

                List<Documento> documentos =
                    await DatabaseHelper.instance.listDocumentos();

                for (Documento doc in documentos) {
                  if (doc.criadoEm == documento.criadoEm) {
                    final notificacao = Notificacao(
                      criadoEm: DateTime.fromMicrosecondsSinceEpoch(
                          now.microsecondsSinceEpoch),
                      id_documento: doc.id,
                    );
                    setState(() {
                      _notifyDbHelper.addNotificacao(notificacao);
                    });
                  }
                }

                List<Categoria> categoria = await DatabaseHelper.instance
                    .getCategoriaById(_selectedValue);

                var cat;
                categoria.forEach((element) {
                  cat = element;
                });

                //adicionar este método para fechar o formulário quando enviar em salvar, assim, após clicar em voltar na lista de documentos, voltará para a pagina principal.
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CategoriaPage(id: _selectedValue)));
              }),
        ]));
  }

  void _pickDateDialogCompetencia() async {
    pickedDataCompetencia = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      locale: const Locale("pt", "BR"),
    );

    if (pickedDataCompetencia != null) {
      setState(() {
        _controllerDataCompetencia.text =
            '${pickedDataCompetencia!.day}/${pickedDataCompetencia!.month}/${pickedDataCompetencia!.year}';
        dataCompetenciaTimeStamp = DateTime.fromMicrosecondsSinceEpoch(
            pickedDataCompetencia!.microsecondsSinceEpoch);
      });
    }
  }

  void _pickDateDialogValidade() async {
    pickedDataValidade = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      locale: const Locale("pt", "BR"),
    );

    if (pickedDataValidade != null) {
      setState(() {
        _controllerDataValidade.text =
            '${pickedDataValidade!.day}/${pickedDataValidade!.month}/${pickedDataValidade!.year}';
        dataValidadeTimeStamp = DateTime.fromMicrosecondsSinceEpoch(
            pickedDataValidade!.microsecondsSinceEpoch);
      });
    }
  }
}
