import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/database_config.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacoes.dart';

class NotificationService {
  NotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  List<Notificacao> listaDeNotificoes = [];

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_android');

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showPushNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }

  Future<int> notifyCount() async {
    int count;
    List<Notificacao> listaNotificacoes = await listarNotificacoes();
    // await _notifyDbHelper.listaNotificacoes();
    if (listaNotificacoes == null || listaNotificacoes.isEmpty) {
      count = 0;
    } else {
      count = listaNotificacoes.length;
    }
    return count;
  }

  Future<List<Notificacao>> listarNotificacoes() async {
    bool teste = true;
    List<Documento> listaDocumentos = await _documentoDbHelper.listDocumentos();
    for (Documento doc in listaDocumentos) {
      var data1 = doc.dataValidade;
      var dataHoje = DateTime.now();
      // if (data1!.isAtSameMomentAs(dataHoje)) {
      if (teste) {
        List<Notificacao> listaNotificacoes =
            await _notifyDbHelper.getNotificacaoByIdDocumento(doc.id!);
        for (Notificacao notificacao in listaNotificacoes) {
          listaDeNotificoes.add(notificacao);
        }
      }
    }
    return listaDeNotificoes;
  }
}
