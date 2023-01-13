import 'package:cron/cron.dart';
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
  final cron = Cron();

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

  void onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload) {
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
    Notificacao? notify;
    List<Documento> listaDocumentos = await _documentoDbHelper.listDocumentos();
      for (Documento doc in listaDocumentos) {
        var dateAtual = DateTime.now();
        var docDataValidade = doc.dataValidade;

        if (docDataValidade?.difference(dateAtual).inDays == 0) {
        // if(dateAtual.isAtSameMomentAs(docDataValidade!)){
          final notificacao = Notificacao(
            criadoEm: DateTime.now(),
            id_documento: doc.id,
          );
          _notifyDbHelper.addNotificacao(notificacao);
          listaDeNotificacoes = await _notifyDbHelper.listaNotificacoes();
          NotificationService instance = NotificationService();
          instance.showPushNotification(
            id: notify!.id!,
            title: "2File",
            body:
            "O documento ${doc.nome?.toUpperCase()} venceu em ${DateFormat("dd/MM/Y").format(
                doc.dataValidade!)}",
          );

          notificacaoTexto =
          "O documento ${doc.nome} venceu em ${DateFormat("dd/MM/y").format(
              doc.dataValidade!)}";
        }
      }
  }

  //CONTADOR DE NOTIFICAÇÕES
  Future<int> notifyCount() async {
    int count = listaDeNotificacoes.length;
    return count;
  }

  String get textoDaNotificacao {
    return notificacaoTexto;
  }


  //retorn lista de notificações
  List<Notificacao> get NotificaoesList {
    return listaDeNotificacoes;
  }
}