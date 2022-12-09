class Categoria {
  int? id;
<<<<<<< HEAD
  String? nome;
  String? nome_icone;
  DateTime? criadoEm;

  Categoria({this.id, this.nome, this.nome_icone, this.criadoEm});

  factory Categoria.fromMap(Map<String, dynamic> json) => new Categoria(
        id: json['id'],
        nome: json['nome'],
        nome_icone: json['nome_icone'],
        criadoEm: json['criadoEm'],
=======
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
>>>>>>> master
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
<<<<<<< HEAD
      'nome_icone': nome_icone,
      'criadoEm': criadoEm,
=======
      'nomeIcone': nomeIcone,
      'criadoEm': criadoEm.toIso8601String(),
>>>>>>> master
    };
  }
}
