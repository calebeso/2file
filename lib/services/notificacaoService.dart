import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacao.dart';

import '../pages/notificacaoPage.dart';

class NotificationService {
  NotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  NotificacaoPage notificacaoPage = NotificacaoPage();
  List<Notificacao> listaDeNotificacoes = [];
  String notificacaoTexto = '';
  Documento? documento;
  Notificacao? notify;

  //========================METODOS DE LOCAL PUSH NOTIFICATION==============
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
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

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
    required String payload,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
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

  //===========================METODOS DE ADICIONAR E MOSTRAR NOTIFICAÇÕES DO APLICATIVO============================

  Future<void> mostrarNotificacoes() async {
    List<Documento> listaDocumentos = await _documentoDbHelper.listDocumentos();
    for (Documento doc in listaDocumentos) {
      var agora = DateTime.now();
      var docDataValidade = doc.dataValidade;

      if (DateUtils.isSameDay(agora, docDataValidade)) {
        final notificacao = Notificacao(
          criadoEm: DateTime.now(),
          id_documento: doc.id,
          body:
              "O documento ${doc.nome?.toUpperCase()} venceu em ${DateFormat("dd/MM/yyyy").format(doc.dataValidade!)}",
        );

        _notifyDbHelper.addNotificacao(notificacao);
        listaDeNotificacoes = await _notifyDbHelper.listaNotificacoes();
        for (Notificacao n in listaDeNotificacoes) {
          notify = n;
        }
        await showPushNotification(
          id: notify!.id!,
          title: "2File",
          body:
              "O documento ${doc.nome?.toUpperCase()} venceu em ${DateFormat("dd/MM/yyyy").format(doc.dataValidade!)}",
          payload: '/notificacoes',
        );
      }
      documento = await _documentoDbHelper.getDocumentoById(doc.id!);
      // notificacaoTexto =
      //     "O documento ${doc.nome} venceu em ${DateFormat("dd/MM/yyyy").format(doc.dataValidade!)}.";
    }
  }

  String getTextoNotificacao() {
    notificacaoTexto =
        "O documento ${documento!.nome} venceu em ${DateFormat("dd/MM/yyyy").format(documento!.dataValidade!)}.";
    return notificacaoTexto;
  }
}
