import 'dart:core';

import 'package:comida_ja/app/data/models/base_model.dart';

class ItemCardapio implements BaseModel {
  ItemCardapio({
    this.id,
    this.preco = 0.0,
    this.descricao,
    this.nome,
  });

  @override
  int? id;
  double preco;
  String? descricao;
  String? nome;

  @override
  ItemCardapio fromMap(Map<String, dynamic> map) => ItemCardapio(
    id: map["id"],
    preco: map["preco"],
    descricao: map["descricao"],
    nome: map["nome"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "id": id,
    "nome": nome,
    "descricao": descricao,
    "nome": nome,
  };
}