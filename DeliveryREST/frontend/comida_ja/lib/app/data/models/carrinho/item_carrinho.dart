import 'package:comida_ja/app/data/models/base_model.dart';

import '../item_cardapio/item_cardapio.dart';

class ItemCarrinho implements BaseModel {
  ItemCarrinho({
    this.id,
    this.itemCardapio,
    this.quantidade = 1,
  });

  @override
  int? id;
  ItemCardapio? itemCardapio;
  int quantidade;

  @override
  ItemCarrinho fromMap(Map<String, dynamic> map) => ItemCarrinho(
        id: map["id"],
        itemCardapio: ItemCardapio().fromMap(map["itemCardapio"]),
        quantidade: map["quantidade"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "itemCardapio": itemCardapio?.toMap(),
        "quantidade": quantidade,
      };
}
