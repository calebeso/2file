import 'package:first_app/components/listview_categoria.dart';
import 'package:flutter/material.dart';
import 'dart:math';


main() => runApp(TwoFileApp());

class TwoFileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home:HomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<HomePage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste 2File'),
      ),
      body: GestureDetector(
          onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoriaList())
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange[100],
              border: Border.all(color: Colors.deepOrange)
            ),
            child: const Text('Clique Aqui!'),
          ),
        ),
    );
  }
}