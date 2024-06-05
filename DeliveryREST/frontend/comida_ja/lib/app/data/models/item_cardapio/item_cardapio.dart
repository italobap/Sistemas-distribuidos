import 'dart:core';

import 'package:comida_ja/app/data/models/base_model.dart';

class ItemCardapio implements BaseModel {
  ItemCardapio({
    this.id,
    this.preco = 0.0,
    this.descricao,
    this.nome,
    this.quantidade = 1,
  });

  @override
  int? id;
  double preco;
  String? descricao;
  String? nome;
  int quantidade;

  @override
  ItemCardapio fromMap(Map<String, dynamic> map) => ItemCardapio(
        id: map["id"],
        preco: map["preco"],
        descricao: map["descricao"],
        nome: map["nome"],
        quantidade: map["quantidade"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
        "preco": preco,
        "quantidade": quantidade,
      };
}
