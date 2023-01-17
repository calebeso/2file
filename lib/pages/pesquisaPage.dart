import 'package:flutter/material.dart';

class PesquisaPage extends StatefulWidget {
  const PesquisaPage({Key? key}) : super(key: key);

  @override
  State<PesquisaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<PesquisaPage> {
  List<String> meses = [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text('área de pesquisa'),
          create_dropdownsButtons(),
        ],
      ),
    );
  }

  create_dropdownsButtons() {
    return Container(
      margin: const EdgeInsets.all(30),
      color: Colors.orange,
      child: Row(
        children: const [
          Expanded(child: Text('MÊS')),
          Expanded(
            child: Text('ANO'),
          ),
          Expanded(
            child: Text('CATEGORIA'),
          ),

          // DropdownButton(
          //     items: const [], value: const Text('janeiro'), onChanged: null),
        ],
      ),
    );
  }
}
