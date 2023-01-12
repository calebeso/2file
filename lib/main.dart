import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_file/pages/homePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_file/databases/database_config.dart';
import 'package:to_file/services/notificacaoService.dart';
import 'package:to_file/services/notification/pushNotificationService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.initDatabase();
  // NotificationService notificationService = NotificationService();
  // notificationService.initializeNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("pt", "BR")
        ],
        debugShowCheckedModeBanner: false,
        home: HomePage() // tela inicial do App
        );
  }
}
