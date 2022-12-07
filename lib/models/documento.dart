import 'categoria.dart';

class Documento {
  int? id;
  String? nome;
  DateTime? dataCompetencia;
  DateTime? dataValidade;
  DateTime? criadoEm;
  int? categoria_id;

  Documento(
      {this.id,
      this.nome,
      this.dataCompetencia,
      this.dataValidade,
      this.criadoEm,
      this.categoria_id});

  factory Documento.fromMap(Map<String, dynamic> json) => new Documento(
        id: json['id'],
        nome: json['nome'],
        dataCompetencia: json['dataCompetencia'],
        dataValidade: json['dataValidade'],
        criadoEm: json['criadoEm'],
        categoria_id: json['categoria_id'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'dataCompetencia': dataCompetencia?.microsecondsSinceEpoch,
      'dataValidade': dataValidade?.microsecondsSinceEpoch,
      'criadoEm': criadoEm?.microsecondsSinceEpoch,
      'categoria_id': categoria_id,
    };
  }
}
