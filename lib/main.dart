import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_file/pages/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TwoFileApp());
}

class TwoFileApp extends StatelessWidget {
  const TwoFileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("pt", "BR")
        ],
        debugShowCheckedModeBanner: false,
        home: HomePage() // tela inicial do App
        );
  }
}
