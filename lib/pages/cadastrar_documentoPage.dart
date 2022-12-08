// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../database/database_config.dart';
import '../models/documento.dart';
import 'categoria_page.dart';

class CadastrarDocumentoPage extends StatefulWidget {
  const CadastrarDocumentoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarDocumentoPage> createState() => _CadastrarDocumentoPageState();
}

class _CadastrarDocumentoPageState extends State<CadastrarDocumentoPage> {
  final textController = TextEditingController();

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Adicionar documento'),
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: <Widget>[
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
        TextField(
            controller: _controllerDataValidade,
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Data de Validade"),
            readOnly: true,
            onTap: () {
              _pickDateDialogValidade();
            }),
        const SizedBox(height: 32),
        ElevatedButton(
          child: const Text('Salvar'),
          onPressed: () {
            final documento = Documento(
              nome: _controllerNome.text,
              dataCompetencia: pickedDataCompetencia!,
              dataValidade: pickedDataValidade!,
              criadoEm: DateTime.now(),
              categoria_id: 
            );

            DatabaseHelper.instance.addDocumento(documento);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const CategoriaPage()));
          },
        )
      ]),
    );
  }

  void _pickDateDialogCompetencia() async {
    pickedDataCompetencia = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2023),
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
      lastDate: DateTime(2023),
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
