import 'package:to_file/models/documento.dart';

class Notificacao {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;
  final DateTime? criadoEm;
  final int? id_documento;

  Notificacao({
    this.id,
    required this.criadoEm,
    required this.id_documento,
    this.title,
    required this.body,
    this.payload,
  });

  factory Notificacao.fromMap(Map<String, dynamic> json) => Notificacao(
        id: json['id'],
        criadoEm: DateTime.parse(json['criadoEm']),
        id_documento: json['id_documento'],
        body: json['body'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criadoEm': criadoEm!.toIso8601String(),
      'id_documento': id_documento,
      'body': body,
    };
  }
}
