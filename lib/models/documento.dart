import 'categoria.dart';

class Documento {
  int? id;
  String? nome;
  DateTime? dataCompetencia;
  //String? nomeImagem;
  DateTime? dataValidade;
  DateTime? criadoEm;
  //Categoria? categoriaId;

  Documento({
    this.id,
    this.nome,
    this.dataCompetencia,
    //this.nomeImagem,
    this.dataValidade,
    this.criadoEm,
    //this.categoriaId,
  });
}
