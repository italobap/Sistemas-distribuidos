import 'package:comida_ja/app/data/models/base_model.dart';

import '../item_cardapio/item_cardapio.dart';

class Carrinho implements BaseModel {
  Carrinho({
    this.id,
    this.itensCarrinho = const [],
    this.valorEntrega = 0,
    this.precoTotal = 0,
  });

  @override
  int? id;
  List<ItemCardapio> itensCarrinho;
  double valorEntrega;
  double precoTotal;

  @override
  Carrinho fromMap(Map<String, dynamic> map) => Carrinho(
      id: map["id"],
      itensCarrinho: map["itensCarrinho"] == null
          ? []
          : List<ItemCardapio>.from(
              map["itensCarrinho"].map((x) => ItemCardapio().fromMap(x))),
      valorEntrega: map["valorEntrega"],
      precoTotal: map["precoTotal"]);

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "itensCarrinho": itensCarrinho.map((x) => x.toMap()).toList(),
        "valorEntrega": valorEntrega,
        "precoTotal": precoTotal,
      };
}
