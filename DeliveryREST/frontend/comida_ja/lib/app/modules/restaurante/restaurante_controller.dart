import 'dart:math';

import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';
import 'package:comida_ja/app/data/models/item_cardapio/item_cardapio.dart';
import 'package:comida_ja/app/modules/carrinho/carrinho_page.dart';
import 'package:flutter/cupertino.dart';

import '../../data/dependencies/navigation/nav.dart';
import '../../data/models/restaurante/restaurante.dart';

class RestauranteController extends ChangeNotifier {
  Restaurante? restaurante;

  List<ItemCardapio> itensCardapio = [];

  Carrinho? carrinho;

  Future<void> initController(Restaurante restaurante) async {
    this.restaurante = restaurante;
    getCardapio();
    notifyListeners();
  }

  void getCardapio() {
    var rnd = Random();
    for (int i = 0; i < 5; i++) {
      itensCardapio.add(ItemCardapio(
          nome: "Nome $i",
          preco: rnd.nextDouble() * 10,
          descricao: "Descrição $i"));
    }
  }

  void addCarrinho(ItemCardapio item) {
    carrinho ??= Carrinho(
        valorEntrega: restaurante?.valorEntrega ?? 0,
        itensCarrinho: [],
        precoTotal: 0);
    carrinho?.itensCarrinho.add(item);
    carrinho?.precoTotal += item.preco * item.numItems;

    notifyListeners();
  }

  Future<void> navToCarrinho(BuildContext context) async {
    await Nav.push(context, page: CarrinhoPage(carrinho: carrinho));
  }
}
