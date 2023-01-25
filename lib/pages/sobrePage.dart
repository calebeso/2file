import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  State<SobrePage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xff0C322C),
          title: const Text('Sobre'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Sobre'),
            Tab(text: 'Termos de Serviço'),
          ]),
        ),
        body: TabBarView(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      child: const Text(
                        'Desenvolvedores',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: const <Widget>[
                        Text(
                          'Angélica Campos Benitez Barbosa',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Calebe Augusto Santana de Oliveira',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'William Ricardo Munaretto',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      child: const Text(
                        'Descrição',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: const Text(
                        'Aplicativo que permite capturar, armazenar e gerenciar arquivos de imagem, por meio do dispositivo móvel, de maneira simples, rápida e prática.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/appbar.png',
                      height: 200,
                    ),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Version: ${snapshot.data!.version}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 50),
                      child: const Text(
                        'O app 2File oferece um serviço gratuito, não coleta dados pessoais e não gera vínculo contratual entre o usuário e os desenvolvedores. O serviço oferecido é de armazenamento e gerenciamento de documentos através de imagens. Uma vez que os arquivos são armazenados somente dentro do dispositivo, as informações contidas nas imagens são de inteira responsabilidade do usuário. Esperamos que faça bom uso e proveito da aplicação e qualquer critica, informação, bugs, nos seja informado através do email "2file@gmail.com" para que possamos continuar melhorando',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
