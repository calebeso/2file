class Documento {
  int? id;
  String nome;
  // DateTime criadoEm;
  // DateTime dataCompetencia;
  // DateTime dataValidade;
  // Categoria idCategoria;

  Documento({
    this.id,
    required this.nome,
    // required this.criadoEm,
    // required this.dataCompetencia,
    // required this.dataValidade,
    //inserir o this.idCategoria
  });

  factory Documento.fromMap(Map<String, dynamic> json) => Documento(
        id: json['id'],
        nome: json['nome'],
        // dataCompetencia: DateTime.parse(['data_competencia'].toString()),
        // dataValidade: DateTime.parse(['data_validade'].toString()),
        // criadoEm: DateTime.parse(['criado_em'].toString()),
        // inserir o campo idCategoria
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nome': nome,
        // 'data_competencia': dataCompetencia.toString(),
        // 'data_validade': dataValidade.toString(),
        // 'criado_em': criadoEm.toString(),
        //inserir o campo idCategoria
      };
}
