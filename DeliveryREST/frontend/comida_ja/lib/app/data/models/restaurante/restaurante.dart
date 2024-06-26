import 'package:comida_ja/app/data/models/base_model.dart';

import '../../enum/enum_tipo_restaurante.dart';
import '../item_cardapio/item_cardapio.dart';

class Restaurante implements BaseModel {
  Restaurante({
    this.id,
    this.nome,
    this.tipoComida,
    this.cardapio = const [],
    this.valorEntrega = 0,
    this.valorAvaliacao = 0,
  });

  @override
  int? id;
  String? nome;
  EnumTipoComida? tipoComida;
  List<ItemCardapio> cardapio;
  double valorEntrega;
  double valorAvaliacao;

  @override
  Restaurante fromMap(Map<String, dynamic> map) => Restaurante(
        id: map["id"],
        nome: map["nome"],
        tipoComida: EnumTipoComida.values.byName(map["tipoComida"]),
        cardapio: map["cardapio"] != null ? [] : [],
        valorEntrega: map["valorEntrega"] ?? 0,
        valorAvaliacao: map["valorAvaliacao"] ?? 0,
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "tipoComida": tipoComida?.name,
        "cardapio": cardapio.map((x) => x.toMap()).toList(),
        "valorEntrega": valorEntrega,
        "valorAvaliacao": valorAvaliacao,
      };
}
