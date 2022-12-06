class Documento{

  int? id;
  String? nome;
  DateTime? criadoEm;


  Documento({this.id, this.nome, this.criadoEm});

  static fromMap(Map<String, Object?> e) {}

}
