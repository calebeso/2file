import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/widgets/categoria_dropdown.dart';

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

  DateTime? pickedDataCompetencia;
  DateTime? pickedDataValidade;
  DateTime? dataCompetenciaTimeStamp;
  DateTime? dataValidadeTimeStamp;

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
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Nome do Documento'),
          ),
          const SizedBox(height: 24),
          TextField(
              controller: _controllerDataCompetencia,
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Data de Competência"),
              readOnly: true,
              onTap: () {
                _pickDateDialogCompetencia();
              }),
          TextField(
              controller: _controllerDataValidade,
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Data de Validade"),
              readOnly: true,
              onTap: () {
                _pickDateDialogValidade();
              }),
          const SizedBox(height: 32),
          ElevatedButton(
              child: Text('Salvar'),
              onPressed: () async {
                var now = DateTime.now();

                final documento = Documento(
                    nome: _controllerNome.text,
                    dataCompetencia: dataCompetenciaTimeStamp,
                    dataValidade: dataValidadeTimeStamp,
                    criadoEm: DateTime.fromMicrosecondsSinceEpoch(
                        now!.microsecondsSinceEpoch),
                    categoria_id: 1);

                await DatabaseHelper.instance.addDocumento(documento);
              }),
        ]));
  }

  void _pickDateDialogCompetencia() async {
    pickedDataCompetencia = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2023),
      locale: Locale("pt", "BR"),
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
      lastDate: DateTime(2023),
      locale: Locale("pt", "BR"),
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
