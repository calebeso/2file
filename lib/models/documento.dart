import 'categoria.dart';

class Documento{

  int? id;
  String? nome;
  DateTime? dataCompetencia;
  String? nomeImagem;
  DateTime? validade;
  DateTime? criadoEm;
  Categoria? idCategoria;

  Documento({this.id, this.nome, this.dataCompetencia, this.nomeImagem, this.validade, this.criadoEm, this.idCategoria});


}