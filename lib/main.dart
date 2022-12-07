import 'package:flutter/material.dart';
import 'package:to_file/databases/database_helper.dart';
import 'package:to_file/pages/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage() // tela inicial do App
        );
  }
}
