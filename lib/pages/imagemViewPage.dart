import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:to_file/models/documento.dart';
import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import '../databases/documentoDbHelper.dart';

// class ImagemViewPage extends StatelessWidget {
//   ImagemViewPage({super.key, this.documento});

//   File? arquivo;
//   String? pastaArquivos;
//   Documento? documento;
//   // final String caminhoImagem = '/data/data/com.example.to_file/cache/';
//   final String caminhoImagem = '';
//   // final String caminhoImagem = 'assets/arquivos/';
//   recuperaDiretorioDeDocs() async {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     pastaArquivos = directory.path;
//   }

//   @override
//   Widget build(BuildContext context) {
//     String nomeArquivo = "${documento!.nome_imagem}";
//     // print(caminhoImagem + nomeArquivo);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff0C322C),
//         title: Text("${documento!.nome}"),
//       ),
//       body: PhotoView(
//         imageProvider: AssetImage(bundle: null, caminhoImagem + nomeArquivo),
//         minScale: PhotoViewComputedScale.contained * 0.8,
//         maxScale: PhotoViewComputedScale.covered * 2,
//         backgroundDecoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//         loadingBuilder: (context, event) => const CircularProgressIndicator(),
//       ),
//     );
//   }
// }

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
    File arquivo = File('$pastaArquivos/${documento!.nome_imagem}');
    String imagem = '$pastaArquivos/${documento!.nome_imagem}';
    // print(caminhoImagem + nomeArquivo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Text(documento!.nome),
      ),
      body: PhotoView(
        imageProvider: Image.file(arquivo).image,
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
      ),
    );
  }
}

//receber o Documento pelo construtor e pegar o nome da foto +  caminho da pasta para mostrar a imagem
// e mostrar o nome do documento no title: do Appbar