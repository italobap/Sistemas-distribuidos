import 'package:comida_ja/app/data/models/item_cardapio/item_cardapio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/restaurante/restaurante.dart';

class RestauranteController extends ChangeNotifier {
  Restaurante? restaurante;

  List<ItemCardapio> itensCardapio = [];

  Future<void> initController(Restaurante restaurante) async {
    this.restaurante = restaurante;
    getCardapio();
    notifyListeners();
  }

  void getCardapio() {
    for (int i = 0; i < 5; i++) {
      itensCardapio.add(ItemCardapio(
          nome: "Nome $i", preco: i.toDouble(), descricao: "Descrição $i"));
    }
  }
}
