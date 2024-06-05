import 'package:comida_ja/app/data/models/base_model.dart';

import 'item_carrinho.dart';

class Carrinho implements BaseModel {
  Carrinho({
    this.id,
    this.itensCarrinho = const [],
    this.valorEntrega = 0,
    this.precoTotal = 0,
  });

  @override
  int? id;
  List<ItemCarrinho> itensCarrinho;
  double valorEntrega;
  double precoTotal;

  @override
  Carrinho fromMap(Map<String, dynamic> map) => Carrinho(
      id: map["id"],
      itensCarrinho: map["itensCarrinho"] == null
          ? []
          : List<ItemCarrinho>.from(
              map["itensCarrinho"].map((x) => ItemCarrinho().fromMap(x))),
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
