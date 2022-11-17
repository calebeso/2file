import 'package:first_app/pages/listview_categoria_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';


main() => runApp(TwoFileApp());

class TwoFileApp extends StatefulWidget {
  @override
  State<TwoFileApp> createState() => _TwoFileAppState();
}

class _TwoFileAppState extends State<TwoFileApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();


    return MaterialApp(
      home:CategoriaListPage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: const Color(0xff0C322C),
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

