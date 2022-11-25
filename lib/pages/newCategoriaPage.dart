import 'package:flutter/material.dart';

class NewCategoriaPage extends StatefulWidget {
  const NewCategoriaPage({Key? key}) : super(key: key);

  @override
  State<NewCategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<NewCategoriaPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Adicionar Categoria'),
      ),
    );
  }
}