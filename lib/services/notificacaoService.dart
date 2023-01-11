import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:to_file/databases/NotificacaoDbHelper.dart';
import 'package:to_file/databases/documentoDbHelper.dart';
import 'package:to_file/models/documento.dart';
import 'package:to_file/models/notificacoes.dart';

class NotificationService {
  NotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final NotifyDbHelper _notifyDbHelper = NotifyDbHelper();
  final DocumentoDbHelper _documentoDbHelper = DocumentoDbHelper();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  List<Notificacao> listaDeNotificacoes = [];

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
  //LISTAR NOTIFICAÇÕES DO BANCO DE DADOS SQL
  //APLICAR REGRA DE DATA E COLOCAR NETODO INITsTATE NA HOME PAGE
  Future<List<Notificacao>> listarNotificacoes() async {
    // bool teste = true;
    List<Documento> listaDocumentos = await _documentoDbHelper.listDocumentos();

    // List<Notificacao> listaNotificacoes =
    //     await _notifyDbHelper.getNotificacaoByIdDocumento(doc.id!);

    //PASSAR O SHOWPUSHNOTIFICATION() AQUI DENTRO PARA ENVIAR A MENSAGEM AO DISPOSITIVO SE APLICADA A REGRA.
    listaDeNotificacoes = await _notifyDbHelper.listaNotificacoes();
    return listaDeNotificacoes;
  }

  //CONTADOR DE NOTIFICAÇÕES
  Future<int> notifyCount() async {
    List<Notificacao> notifys = await listarNotificacoes();
    return notifys.length;
  }

  //METODO TESTE DE PUSH NOTIFICATION

  //??? CRIAR METODO PARA COLOCAR NOTIFICAÇÃO NO BANCO DE DADOS CONFORME REGRA DE CONFRONTO DE DATAS?
  //LOOPING ETERNO? CONSUMO DE MEMÓRIA?
  //VERIFICAR QUAL É MELHOR!
}
