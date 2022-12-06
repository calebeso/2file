class Categoria {
  int? id;
  String nome;
  // String? nome_icone;
  // DateTime criadoEm;

  Categoria({
    this.id,
    required this.nome,
  });

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        id: json['id'],
        nome: json['name'],
        // criadoEm: json['criado_em'],
        //inserir o campo nomeIcone
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': nome,
        // 'criado_em': criadoEm,
        //inserir o campo nomeIcone
      };
}
