class Categoria {
  int? id;
  String? nome;
  String? nome_icone;
  DateTime? criadoEm;

  Categoria({this.id, this.nome, this.nome_icone, this.criadoEm});

  factory Categoria.fromMap(Map<String, dynamic> json) => new Categoria(
        id: json['id'],
        nome: json['nome'],
        nome_icone: json['nome_icone'],
        criadoEm: json['criadoEm'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'nome_icone': nome_icone,
      'criadoEm': criadoEm,
    };
  }
}
