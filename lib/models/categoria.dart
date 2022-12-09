class Categoria {
  int? id;
  String nome;
  String nomeIcone;
  DateTime criadoEm;

  Categoria(
      {this.id,
      required this.nome,
      required this.nomeIcone,
      required this.criadoEm});

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        id: json['id'],
        nome: json['nome'],
        nomeIcone: json['nomeIcone'],
        criadoEm: DateTime.parse(json['criadoEm']),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'nomeIcone': nomeIcone,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }
}
