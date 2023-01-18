import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:to_file/models/documento.dart';

class ImagemViewPage extends StatelessWidget {
  ImagemViewPage({super.key, this.documento});

  Documento? documento;
  final String caminhoImagem = '/data/data/com.example.to_file/cache/';
  // final String caminhoImagem = 'assets/arquivos/';

  @override
  Widget build(BuildContext context) {
    String nomeArquivo = "${documento!.nome_imagem}";
    // print(caminhoImagem + nomeArquivo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Text("${documento!.nome}"),
      ),
      body: PhotoView(
        imageProvider: AssetImage(bundle: null, caminhoImagem + nomeArquivo),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        loadingBuilder: (context, event) => const CircularProgressIndicator(),
      ),
    );
  }
}


//receber o Documento pelo construtor e pegar o nome da foto +  caminho da pasta para mostrar a imagem
// e mostrar o nome do documento no title: do Appbar