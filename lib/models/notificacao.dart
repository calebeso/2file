class Notificacao {
  int? id;
  DateTime criadoEm;

  Notificacao({this.id, required this.criadoEm});

  factory Notificacao.fromMap(Map<String, dynamic> json) => Notificacao(
        id: json['id'],
        criadoEm: json['criado_em'],
        //inserir o campo id_documento
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'criado_em': criadoEm,
        //inserir o campo id_documento
      };
}
