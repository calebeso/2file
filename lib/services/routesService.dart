import 'package:flutter/cupertino.dart';
import 'package:to_file/pages/notificacaoPage.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{'/notificacoes': (_) => NotificacaoPage()};

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
