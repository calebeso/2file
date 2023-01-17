import 'package:flutter/material.dart';

class PesquisaPage extends StatefulWidget {
  const PesquisaPage({Key? key}) : super(key: key);

  @override
  State<PesquisaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<PesquisaPage> {
  final valorDropdown = ValueNotifier('');
  final List<String> dropdownListaMeses = [
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
          create_dropdownsButtons(),
        ],
      ),
    );
  }

  create_dropdownsButtons() {
    return Container(
      margin: const EdgeInsets.all(30),
      //color: Colors.orange,
      child: Row(
        children: [
          // MÊS
          ValueListenableBuilder(
              valueListenable: valorDropdown,
              builder: (BuildContext context, String value, _) {
                return DropdownButton<String>(
                  hint: const Text('mês'),
                  value: (value.isEmpty) ? null : value,
                  onChanged: (opcao) => valorDropdown.value = opcao.toString(),
                  items: dropdownListaMeses
                      .map(
                        (opcao) => DropdownMenuItem(
                          child: Text(opcao),
                          value: opcao,
                        ),
                      )
                      .toList(),
                );
              }),

          // ANO
          ValueListenableBuilder(
              valueListenable: valorDropdown,
              builder: (BuildContext context, String value, _) {
                return DropdownButton<String>(
                  hint: const Text('ano'),
                  value: (value.isEmpty) ? null : value,
                  onChanged: (opcao) => valorDropdown.value = opcao.toString(),
                  items: dropdownListaMeses
                      .map(
                        (opcao) => DropdownMenuItem(
                          child: Text(opcao),
                          value: opcao,
                        ),
                      )
                      .toList(),
                );
              }),

          // CATEGORIA
          ValueListenableBuilder(
              valueListenable: valorDropdown,
              builder: (BuildContext context, String value, _) {
                return DropdownButton<String>(
                  hint: const Text('categoria'),
                  value: (value.isEmpty) ? null : value,
                  onChanged: (opcao) => valorDropdown.value = opcao.toString(),
                  items: dropdownListaMeses
                      .map(
                        (opcao) => DropdownMenuItem(
                          child: Text(opcao),
                          value: opcao,
                        ),
                      )
                      .toList(),
                );
              }),
        ],
      ),
    );
  }
}
