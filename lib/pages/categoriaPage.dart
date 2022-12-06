import 'package:flutter/material.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({Key? key}) : super(key: key);

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: const Text('Categoria'),
      ),
    );
  }
}
