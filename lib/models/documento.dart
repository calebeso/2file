class Documento {
  int? id;
  String? nome;
  DateTime? dataCompetencia;
  DateTime? dataValidade;
  String? nome_imagem;
  DateTime? criadoEm;
  int categoria_id;

  Documento(
      {this.id,
      this.nome,
      this.dataCompetencia,
      this.dataValidade,
      this.nome_imagem,
      this.criadoEm,
      required this.categoria_id});

  factory Documento.fromMap(Map<String, dynamic> json) => Documento(
        id: json['id'],
        nome: json['nome'],
        dataCompetencia: DateTime.parse(json['dataCompetencia']),
        dataValidade: DateTime.parse(json['dataValidade']),
        nome_imagem: json['nome_imagem'],
        criadoEm: DateTime.parse(json['criadoEm']),
        categoria_id: json['categoria_id'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'dataCompetencia': dataCompetencia!.toIso8601String(),
      'dataValidade': dataValidade!.toIso8601String(),
      'nome_imagem': nome_imagem,
      'criadoEm': criadoEm!.toIso8601String(),
      'categoria_id': categoria_id,
    };
  }
}
