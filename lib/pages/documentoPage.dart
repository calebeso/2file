import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/categoria.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/pages/categoria_page.dart';

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
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();

  ImagePicker imagePicker = ImagePicker();
  File? arquivo;
  String? nomeArquivo;

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
          arquivo == null ? Container() : Image.file(arquivo!),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => {
              capturaImagemCamera(),
            },
            icon: Icon(Icons.camera_alt),
            label: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text('Tire uma foto'),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                textStyle: TextStyle(
                  fontSize: 18,
                )),
          ),
          OutlinedButton.icon(
            icon: Icon(Icons.attach_file),
            label: Text('Selecione um arquivo'),
            onPressed: () => {pegaImagemGaleria()},
          ),
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
                    nome_imagem: nomeArquivo,
                    categoria_id: _selectedValue);

                setState(() {
                  _documentoDbHelper.addDocumento(documento);
                });

                List<Documento> documentos =
                    await _documentoDbHelper.listDocumentos();

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
                            CategoriaPage(categoria: cat)));
              }),
        ]));
  }

  void _pickDateDialogCompetencia() async {
    pickedDataCompetencia = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
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
      lastDate: DateTime(2025),
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

  pegaImagemGaleria() async {
    final PickedFile? imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (imagemTemporaria != null) {
      setState(() {
        arquivo = File(imagemTemporaria.path);
        nomeArquivo = imagemTemporaria.path.split('/').last;
      });
    }
  }

  capturaImagemCamera() async {
    final PickedFile? imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.camera);

    if (imagemTemporaria != null) {
      setState(() {
        arquivo = File(imagemTemporaria.path);
        nomeArquivo = imagemTemporaria.path.split('/').last;
      });
    }
  }
}
