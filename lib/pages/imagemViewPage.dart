import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:to_file/models/documento.dart';
import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import '../databases/documentoDbHelper.dart';

class ImagemViewPage extends StatefulWidget {
  const ImagemViewPage({super.key, required this.id_documento});

  final int id_documento;

  @override
  State<ImagemViewPage> createState() => _ImagemState();
}

class _ImagemState extends State<ImagemViewPage> {
  String? pastaArquivos;
  Documento? documento;
  final String caminhoImagem = '';
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();

  recuperaDiretorioDeDocs() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    setState(() {
      pastaArquivos = directory.path;
    });
  }

  @override
  void initState() {
    recuperaDiretorioDeDocs();
    _pegarDocumento();
    super.initState();
  }

  _pegarDocumento() async {
    Documento doc =
        await _documentoDbHelper.getDocumentoById(widget.id_documento);
    setState(() {
      documento = doc;
    });
  }

  @override
  Widget build(BuildContext context) {
    File? arquivo = documento != null
        ? File('$pastaArquivos/${documento!.nome_imagem}')
        : null;
    String imagem =
        documento != null ? '$pastaArquivos/${documento!.nome_imagem}' : '';
    // print(caminhoImagem + nomeArquivo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Text(
            documento != null ? documento!.nome : 'Carregando Documento...'),
      ),
      body: documento != null && arquivo != null
          ? PhotoView(
              imageProvider: Image.file(arquivo!).image,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              backgroundDecoration: const BoxDecoration(
                color: Colors.white,
              ),
              loadingBuilder: (context, event) => const Center(
                  child: ColorfulCircularProgressIndicator(
                colors: [Colors.blue, Colors.red, Colors.amber, Colors.green],
                strokeWidth: 5,
                indicatorHeight: 40,
                indicatorWidth: 40,
              )),
            )
          : const Center(
              child: Text('Carregando Documento...'),
            ),
    );
  }
}

//receber o Documento pelo construtor e pegar o nome da foto +  caminho da pasta para mostrar a imagem
// e mostrar o nome do documento no title: do Appbar