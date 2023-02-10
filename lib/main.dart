import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_file/pages/homePage.dart';

import 'databases/database_config.dart';
import 'services/notificacaoService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.initDatabase();
  final NotificationService _notificationService = NotificationService();
  _notificationService.initializeNotifications();
  final cron = Cron();
  cron.schedule(
    Schedule.parse('*/60 * * * * *'),
    () async => {
      await _notificationService.mostrarNotificacoes(),
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(localizationsDelegates: [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ], supportedLocales: [
      Locale("pt", "BR")
    ], debugShowCheckedModeBanner: false, home: HomePage() //
        );
  }
}
