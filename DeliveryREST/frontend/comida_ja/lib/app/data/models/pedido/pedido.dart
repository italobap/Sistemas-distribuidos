import 'dart:core';

import 'package:comida_ja/app/data/models/base_model.dart';
import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';

import '../../enum/enum_status_entrega.dart';

class Pedido implements BaseModel {
  Pedido({
    this.id,
    this.carrinho,
    this.status = EnumStatusEntrega.enviado,
  });

  @override
  int? id;
  Carrinho? carrinho;
  EnumStatusEntrega status;

  @override
  Pedido fromMap(Map<String, dynamic> map) => Pedido(
        id: map["id"],
        carrinho: map["carrinho"] != null
            ? Carrinho().fromMap(map["carrinho"])
            : null,
        status: EnumStatusEntrega.values.byName(map["status"]),
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "carrinho": carrinho?.toMap(),
        "status": status.name,
      };
}
