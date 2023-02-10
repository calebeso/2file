import 'package:flutter/material.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:to_file/databases/categoriaDbHelper.dart';
import 'package:to_file/mixins/validations_mixin.dart';
import 'package:to_file/models/icones.dart';

import '../models/categoria.dart';

class NewCategoriaPage extends StatefulWidget {
  NewCategoriaPage({this.atualizarListaCategorias, this.categoria});

  final Categoria? categoria;
  final atualizarListaCategorias;

  @override
  State<NewCategoriaPage> createState() => _NewCategoriaPageState();
}

class _NewCategoriaPageState extends State<NewCategoriaPage>
    with ValidationsMixin {
  final TextEditingController nomeCategoriaController = TextEditingController();

  final TextEditingController iconeCategoriaController =
      TextEditingController();

  final Map<String, IconData> myIconCollection = Icones.mIcons;

  CategoriaDbHelper categoriaCrud = CategoriaDbHelper();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.categoria != null) {
      nomeCategoriaController.text = widget.categoria!.nome;
      iconeCategoriaController.text = widget.categoria!.nomeIcone;
    }
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Text(
            '${widget.categoria == null ? "Adicionar Categoria" : "Editar Categoria"}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: nomeCategoriaController,
                  maxLength: 35,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome da categoria',
                    hintText: 'nome',
                    filled: true,
                    fillColor: Color(0xffDEF1EB),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                IconPicker(
                  controller: iconeCategoriaController,
                  icon: const Icon(Icons.apps),
                  labelText: "Icone",
                  title: "Selecione um ícone",
                  cancelBtn: "CANCELAR",
                  enableSearch: true,
                  searchHint: 'Pesquisar icone',
                  iconCollection: myIconCollection,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      var form = formKey.currentState;
                      if (form?.validate() ?? false) {
                        inserirCategoria();
                        Navigator.pop(context);
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff30BA78)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.categoria == null ? "Adicionar" : "Atualizar",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
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
      ),
    );
  }

  void inserirCategoria() async {
    if (widget.categoria == null) {
      Categoria categoria = Categoria(
          nome: nomeCategoriaController.text,
          nomeIcone: iconeCategoriaController.text,
          criadoEm: DateTime.now());
      await categoriaCrud.addCategoria(categoria);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Categoria cadastrada com sucesso!"),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xffFE7C3F),
        ),
      );
    } else {
      widget.categoria?.nome = nomeCategoriaController.text;
      widget.categoria?.nomeIcone = iconeCategoriaController.text;
      await categoriaCrud.updateCategoria(widget.categoria!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Categoria atualizada com sucesso!"),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xffFE7C3F),
        ),
      );
    }

    this.widget.atualizarListaCategorias();
    nomeCategoriaController.clear();
    iconeCategoriaController.clear();
  }
}
