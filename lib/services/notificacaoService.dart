import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacao.dart';

class NotificationService {
  NotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  List<Notificacao> listaDeNotificacoes = [];
  String notificacaoTexto = '';

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

  //===========================METODOS DE NOTIFICAÇÕES DO APLICATIVO============================
  // LISTAR NOTIFICAÇÕES DO BANCO DE DADOS SQL
  // APLICAR REGRA DE DATA E COLOCAR NETODO INITsTATE NA HOME PAGE
  Future<void> mostrarNotificacoes() async {
    List<Notificacao> notifys = [];
    Notificacao? notify;
    List<Documento> listaDocumentos = await _documentoDbHelper.listDocumentos();
    for (Documento doc in listaDocumentos) {
      bool teste = true;
      var dateAtual = DateTime.now();
      var docDataValidade = doc.dataValidade;
      // if (datetime.difference(_pickedDateValid!).inDays == 0) {}
      // if (DateUtils.isSameDay(dateAtual, docDataValidade)) {
      if (teste) {
        var notificacao = Notificacao(
          criadoEm: DateTime.now(),
          id_documento: doc.id,
        );
        _notifyDbHelper.addNotificacao(notificacao);
        notifys = await _notifyDbHelper.getNotificacaoByIdDocumento(doc.id!);
        for (Notificacao n in notifys) {
          notify = n;
        }
        showPushNotification(
          id: notify!.id!,
          title: "2File",
          body:
              "O documento ${doc.nome} venceu em ${DateFormat("dd/MM/Y").format(doc.dataValidade!)}",
        );

        notificacaoTexto =
            "O documento ${doc.nome} venceu em ${DateFormat("dd/MM/y").format(doc.dataValidade!)}";
      }
    }
  }

  // Future<List<Notificacao>> mostrarNotificacoes() async {
  //   List<Notificacao> notifys = [];
  //   Notificacao? notify;
  //   List<Documento> listaDocumentos = await _documentoDbHelper.listDocumentos();
  //   for (Documento doc in listaDocumentos) {
  //     bool teste = true;
  //     var dateAtual = DateTime.now();
  //     var docDataValidade = doc.dataValidade;
  //     // if (datetime.difference(_pickedDateValid!).inDays == 0) {}
  //     // if (DateUtils.isSameDay(dateAtual, docDataValidade)) {
  //     if (teste) {
  //       notifys = await _notifyDbHelper.getNotificacaoByIdDocumento(doc.id!);
  //       for (Notificacao n in notifys) {
  //         notify = n;
  //         listaDeNotificacoes.add(n);
  //       }
  //       showPushNotification(
  //         id: notify!.id!,
  //         title: "2File",
  //         body:
  //             "O documento ${doc.nome} venceu em ${DateFormat("dd/MM/y").format(doc.dataValidade!)}",
  //       );

  //       notificacaoTexto =
  //           "O documento ${doc.nome} venceu em ${DateFormat("dd/MM/y").format(doc.dataValidade!)}";
  //     }
  //   }
  //   return listaDeNotificacoes;
  // }

  //CONTADOR DE NOTIFICAÇÕES
  Future<int> notifyCount() async {
    int count = listaDeNotificacoes.length;
    return count;
  }

  String get textoDaNotificacao {
    return notificacaoTexto;
  }
}
