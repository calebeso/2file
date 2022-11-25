import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_file/databases/db_firestore.dart';
import 'package:to_file/models/documento.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_file/pages/listview_categoria_page.dart';

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
  Timestamp? dataCompetenciaTimeStamp;
  Timestamp? dataValidadeTimeStamp;

  List<Documento> listaDocumentos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
          onPressed: () {
            final documento = Documento(
              nome: _controllerNome.text,
              dataCompetencia: pickedDataCompetencia,
              dataValidade: pickedDataValidade,
            );

            createDocumento(documento);

            listaDocumentos.add(documento);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CategoriaListPage()));
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
      locale: Locale("pt", "BR"),
    );

    if (pickedDataCompetencia != null) {
      setState(() {
        _controllerDataCompetencia.text =
            '${pickedDataCompetencia!.day}/${pickedDataCompetencia!.month}/${pickedDataCompetencia!.year}';
        dataCompetenciaTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
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
        dataValidadeTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
            pickedDataValidade!.microsecondsSinceEpoch);
      });
    }
  }

  Future createDocumento(Documento documento) async {
    FirebaseFirestore.instance.collection('documentos').add({
      'nome': documento.nome,
      'data_competencia': documento.dataCompetencia,
      'data_validade': documento.dataValidade,
    });
  }
}
