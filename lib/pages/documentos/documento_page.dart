import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/mixins/validations_mixin.dart';
import 'package:to_file/models/categoria.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacao.dart';
import 'package:to_file/pages/categoria_page2.dart';
// import 'package:to_file/pages/categoria_page.dart';
import 'package:to_file/pages/homePage.dart';
import '../../databases/NotificacaoDbHelper.dart';
import 'package:image_picker/image_picker.dart';
import '../../databases/database_config.dart';
import 'package:path_provider/path_provider.dart';

class DocumentoPage extends StatefulWidget {
  const DocumentoPage({Key? key}) : super(key: key);

  @override
  State<DocumentoPage> createState() => _DocumentoPageState();
}

class _DocumentoPageState extends State<DocumentoPage> with ValidationsMixin {
  Documento? documentoExistente;
  final _formKey = GlobalKey<FormState>();
  final _controllerNome = TextEditingController();
  final _controllerDataCompetencia = TextEditingController();
  final _controllerDataValidade = TextEditingController();
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();

  ImagePicker imagePicker = ImagePicker();
  File? arquivo;
  String? nomeArquivo;
  String? pastaArquivos;

  var _selectedValue;
  var _categorias = <DropdownMenuItem>[];

  DateTime? pickedDataCompetencia;
  DateTime? pickedDataValidade;
  DateTime? dataCompetenciaTimeStamp;
  DateTime? dataValidadeTimeStamp;

  @override
  void initState() {
    _loadCategorias();
    super.initState();
  }

  _loadCategorias() async {
    var categorias = await DatabaseHelper.instance.todasCategorias();
    categorias.forEach((element) {
      if (this.mounted) {
        setState(() {
          _categorias.add(DropdownMenuItem(
            child: Text(element.nome),
            value: element.id,
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Text('Cadastrar documento'),
      ),
      body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16), children: <Widget>[
            const SizedBox(height: 40),
            TextFormField(
              controller: _controllerNome,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Nome do Documento'),
              validator: isNotEmpty,
            ),
            const SizedBox(height: 24),
            TextFormField(
                controller: _controllerDataCompetencia,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Data de Competência"),
                readOnly: true,
                validator: isNotEmpty,
                onTap: () {
                  _pickDateDialogCompetencia();
                }),
            const SizedBox(height: 24),
            TextFormField(
                controller: _controllerDataValidade,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Data de Validade"),
                readOnly: true,
                validator: (val) => combine([
                      () => isNotEmpty(val),
                      () => isCompetenciaMenor(
                          dataValidadeTimeStamp, dataCompetenciaTimeStamp),
                    ]),
                onTap: () {
                  _pickDateDialogValidade();
                }),
            const SizedBox(height: 24),
            DropdownButtonFormField(
              hint: const Text('Selecione uma categoria'),
              validator: isCategoriaNotEmpty,
              items: _categorias,
              value: _selectedValue,
              onChanged: (value) {
                if (this.mounted) {
                  setState(() {
                    _selectedValue = value;
                  });
                }
              },
            ),
            const SizedBox(height: 32),
            arquivo != null
                ? Image.file(arquivo!)
                : Container(
                    padding: EdgeInsets.all(20),
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 35,
                    ),
                  ),
            const SizedBox(height: 32),
            Row(children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => {
                    capturaImagemCamera(),
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text('Camera'),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0C322C),
                      elevation: 0.0,
                      textStyle: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff0C322C),
                      primary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 18,
                      )),
                  icon: Icon(Icons.attach_file),
                  label: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text('Galeria'),
                  ),
                  onPressed: () => {pegaImagemGaleria()},
                ),
              ),
            ]),
            const SizedBox(height: 32),
            ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff30BA78),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Text('Adicionar'), Icon(Icons.add)],
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    salvaDocumento();

                    const snack = SnackBar(
                        content: Text(
                            'Voce precisa anexar uma imagem ao documento!'),
                        backgroundColor: Colors.deepOrange);

                    List<Categoria> categoria = await DatabaseHelper.instance
                        .getCategoriaById(_selectedValue);

                    var cat;
                    categoria.forEach((element) {
                      cat = element;
                    });

                    if (nomeArquivo == null) {
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CategoriaPage2(categoria: cat)));
                    }
                  }
                }),
          ])),
    );
  }

  void _pickDateDialogCompetencia() async {
    var initialDate = DateTime.now();

    pickedDataCompetencia = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      locale: const Locale("pt", "BR"),
    );

    if (pickedDataCompetencia != null) {
      if (this.mounted) {
        setState(() {
          _controllerDataCompetencia.text =
              '${pickedDataCompetencia!.day}/${pickedDataCompetencia!.month}/${pickedDataCompetencia!.year}';
          dataCompetenciaTimeStamp = DateTime.fromMicrosecondsSinceEpoch(
              pickedDataCompetencia!.microsecondsSinceEpoch);
        });
      }
    }
  }

  void _pickDateDialogValidade() async {
    var initialDate = DateTime.now();

    pickedDataValidade = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      locale: Locale("pt", "BR"),
    );

    if (pickedDataValidade != null) {
      if (this.mounted) {
        setState(() {
          _controllerDataValidade.text =
              '${pickedDataValidade!.day}/${pickedDataValidade!.month}/${pickedDataValidade!.year}';
          dataValidadeTimeStamp = DateTime.fromMicrosecondsSinceEpoch(
              pickedDataValidade!.microsecondsSinceEpoch);
        });
      }
    }
  }

  pegaImagemGaleria() async {
    final PickedFile? imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (imagemTemporaria != null) {
      //recupera diretorio
      final Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path;

      nomeArquivo = imagemTemporaria.path.split('/').last;

      final imagemSalva =
          await File(imagemTemporaria.path).copy('$path/$nomeArquivo');

      if (this.mounted) {
        setState(() {
          arquivo = File(imagemTemporaria.path);
        });
      }
    }
  }

  capturaImagemCamera() async {
    final PickedFile? imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.camera);

    if (imagemTemporaria != null) {
      //recupera diretorio
      final Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path;

      nomeArquivo = imagemTemporaria.path.split('/').last;

      final savedImage =
          await File(imagemTemporaria.path).copy('$path/$nomeArquivo');

      if (this.mounted) {
        setState(() {
          arquivo = File(imagemTemporaria.path);
        });
      }
    }
  }

  salvaDocumento() {
    var now = DateTime.now();

    if (nomeArquivo == null) {
      return;
    } else {
      final documento = Documento(
          nome: _controllerNome.text,
          dataCompetencia: dataCompetenciaTimeStamp!,
          dataValidade: dataValidadeTimeStamp!,
          criadoEm:
              DateTime.fromMicrosecondsSinceEpoch(now.microsecondsSinceEpoch),
          nome_imagem: nomeArquivo!,
          categoria_id: _selectedValue);

      _documentoDbHelper.addDocumento(documento);
    }
  }
}
