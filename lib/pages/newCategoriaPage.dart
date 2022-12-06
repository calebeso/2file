import 'package:flutter/material.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:to_file/databases/database_helper.dart';
import 'package:to_file/models/icones.dart';

import '../models/categoria.dart';

class NewCategoriaPage extends StatefulWidget {
  NewCategoriaPage({Key? key}) : super(key: key);

  @override
  State<NewCategoriaPage> createState() => _NewCategoriaPageState();
}

class _NewCategoriaPageState extends State<NewCategoriaPage> {
  final TextEditingController nomeCategoriaController = TextEditingController();

  final TextEditingController iconeCategoriaController =
      TextEditingController();

  final Map<String, IconData> myIconCollection = Icones.mIcons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Adicionar Categoria'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: nomeCategoriaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome da categoria',
                  hintText: 'nome',
                  filled: true,
                  fillColor: Color(0xffDEF1EB),
                ),
              ),
              IconPicker(
                // initialValue: 'favorite',
                controller: iconeCategoriaController,
                icon: const Icon(Icons.apps),
                labelText: "Icone",
                title: "Selecione um ícone",
                cancelBtn: "CANCELAR",
                enableSearch: true,
                searchHint: 'Pesquisar icone',
                iconCollection: myIconCollection,
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    inserirCategoria();
                  });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff30BA78)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Adicionar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.add_box_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // salvar categoria no banco
  void inserirCategoria() async {
    Categoria categoria = Categoria(
        nome: nomeCategoriaController.text,
        nomeIcone: iconeCategoriaController.text,
        criadoEm: DateTime.now());
    await DatabaseHelper.instance.addCategoria(categoria);
    nomeCategoriaController.clear();
    iconeCategoriaController.clear();
  }
}
