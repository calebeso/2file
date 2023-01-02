import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:to_file/databases/database_config.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacoes.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

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
    List<Notificacao> listaNotificacoes =
        await DatabaseHelper.instance.listaNotificaoes();
    if (listaNotificacoes == null || listaNotificacoes.isEmpty) {
      count = 0;
    } else {
      count = listaNotificacoes.length;
    }
    return count;
  }

  //metodo para mostrar noficações tanto no dispositivo quanto na lista de notificações.
  Future<Notificacao> mostrarNofiticacoes() async {
    List<Documento> listDocumentos =
        await DatabaseHelper.instance.listDocumentos();
    List<Notificacao> listNotificacao;
    Notificacao? notificacao;

    for (Documento doc in listDocumentos) {
      if (doc.dataValidade == DateTime.now()) {
        showPushNotification(
            id: doc.id!,
            title: "${doc.nome}",
            body: 'Este documento venceu em ${doc.dataValidade}.');
      }

      listNotificacao =
          await DatabaseHelper.instance.getNotificacaoByIdDocumento(doc.id!);
      for (Notificacao notify in listNotificacao) {
        notificacao = notify;
      }
    }

    return notificacao!;
  }

  //====================métodos que poderão ser usados=========================NÃO DELETAR
  // Future<void> showScheduledNotification(
  //     {required int id,
  //     required String title,
  //     required String body,
  //     required int seconds}) async {
  //   final details = await _notificationDetails();
  //   await _localNotificationService.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     tz.TZDateTime.from(
  //       DateTime.now().add(Duration(seconds: seconds)),
  //       tz.local,
  //     ),
  //     details,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

  // Future<void> showNotificationWithPayload(
  //     {required int id,
  //     required String title,
  //     required String body,
  //     required String payload}) async {
  //   final details = await _notificationDetails();
  //   await _localNotificationService.show(id, title, body, details,
  //       payload: payload);
  // }
}
