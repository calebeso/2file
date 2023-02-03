import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/mixins/validations_mixin.dart';
import 'package:to_file/models/categoria.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacao.dart';
import 'package:to_file/pages/categoria_page.dart';
import 'package:to_file/pages/homePage.dart';
import '../../databases/NotificacaoDbHelper.dart';
import 'package:image_picker/image_picker.dart';
import '../../databases/database_config.dart';
import 'package:path_provider/path_provider.dart';

class EditDocumentoPage extends StatefulWidget {
  final Documento? documento;

  const EditDocumentoPage({Key? key, this.documento}) : super(key: key);

  @override
  State<EditDocumentoPage> createState() => _EditDocumentoPageState();
}

class _EditDocumentoPageState extends State<EditDocumentoPage>
    with ValidationsMixin {
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
    _carregaCategorias();
    _carregaDados();
    super.initState();
  }

  _carregaCategorias() async {
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

  _carregaDados() async {
    if (widget.documento != null) {
      await recuperaDiretorioDeDocs(); // recupera diretorio padrao do dispositivo

      String tempImage = widget.documento!.nome_imagem;
      _controllerNome.text = widget.documento!.nome;

      //datas
      _controllerDataCompetencia.text =
          '${widget.documento!.dataCompetencia.day}/${widget.documento!.dataCompetencia.month}/${widget.documento!.dataCompetencia.year}';
      dataCompetenciaTimeStamp = DateTime.fromMicrosecondsSinceEpoch(
          widget.documento!.dataCompetencia.microsecondsSinceEpoch);

      _controllerDataValidade.text =
          '${widget.documento!.dataValidade.day}/${widget.documento!.dataValidade.month}/${widget.documento!.dataValidade.year}';
      dataValidadeTimeStamp = DateTime.fromMicrosecondsSinceEpoch(
          widget.documento!.dataValidade.microsecondsSinceEpoch);

      _selectedValue = widget.documento!.categoria_id;
      arquivo = File('$pastaArquivos/$tempImage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
          backgroundColor: const Color(0xff0C322C),
          title: Text('Atualizar documento')),
      body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16), children: <Widget>[
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
                _selectedValue = value;
              },
            ),
            const SizedBox(height: 32),
            Image.file(arquivo!),
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
                  if (_formKey.currentState!.validate()) {
                    atualizaDocumento();

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
                    if (arquivo == null) {
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CategoriaPage(categoria: cat)));
                    }
                  }
                }),
          ])),
    );
  }

  void _pickDateDialogCompetencia() async {
    var initialDate = widget.documento?.dataCompetencia != null
        ? widget.documento!.dataCompetencia
        : DateTime.now();

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
    var initialDate = widget.documento?.dataValidade != null
        ? widget.documento!.dataValidade
        : DateTime.now();

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
      final Directory directory =
          await getApplicationDocumentsDirectory(); //recupera diretorio
      String path = directory.path;

      nomeArquivo = imagemTemporaria.path.split('/').last;

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

      await File(imagemTemporaria.path).copy('$path/$nomeArquivo');

      if (this.mounted) {
        setState(() {
          arquivo = File(imagemTemporaria.path);
        });
      }
    }
  }

  atualizaDocumento() {
    if (arquivo == null) {
      return;
    } else {
      widget.documento!.nome = _controllerNome.text;
      widget.documento!.dataCompetencia =
          pickedDataCompetencia ?? widget.documento!.dataCompetencia;
      widget.documento!.dataValidade =
          pickedDataValidade ?? widget.documento!.dataValidade;
      widget.documento!.nome_imagem =
          nomeArquivo ?? widget.documento!.nome_imagem;
      widget.documento!.categoria_id =
          _selectedValue ?? widget.documento!.categoria_id;
      _documentoDbHelper.updateDocumento(widget.documento!);
    }
  }

  recuperaDiretorioDeDocs() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    pastaArquivos = directory.path;
  }
}
