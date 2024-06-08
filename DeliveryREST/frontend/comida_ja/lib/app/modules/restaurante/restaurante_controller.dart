import 'package:comida_ja/app/data/dependencies/http_app/http_app.dart';
import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';
import 'package:comida_ja/app/data/models/item_cardapio/item_cardapio.dart';
import 'package:comida_ja/app/data/repositories/restaurante_repository.dart';
import 'package:comida_ja/app/modules/carrinho/carrinho_page.dart';
import 'package:flutter/cupertino.dart';

import '../../data/dependencies/navigation/nav.dart';
import '../../data/models/carrinho/item_carrinho.dart';
import '../../data/models/restaurante/restaurante.dart';

class RestauranteController extends ChangeNotifier {
  RestauranteRepository repository = RestauranteRepository(httpApp: HttpApp());

  Restaurante? restaurante;

  List<ItemCardapio> itensCardapio = [];

  Carrinho? carrinho;

  int totalItens = 0;

  Future<void> initController(Restaurante restaurante) async {
    this.restaurante = restaurante;
    await getCardapio();
    notifyListeners();
  }

  Future<void> getCardapio() async {
    itensCardapio = await repository.getCardapio(restaurante!.id!);
  }

  void addCarrinho(ItemCardapio item) {
    carrinho ??= Carrinho(
        valorEntrega: restaurante?.valorEntrega ?? 0,
        itensCarrinho: [],
        precoTotal: 0);

    ItemCarrinho newItem =
        ItemCarrinho(itemCardapio: item, quantidade: item.quantidade);

    final index = carrinho!.itensCarrinho
        .indexWhere((item) => item.itemCardapio == newItem.itemCardapio);

    if (index != -1) {
      carrinho!.itensCarrinho[index].quantidade += newItem.quantidade;
    } else {
      carrinho?.itensCarrinho.add(newItem);
    }

    carrinho?.precoTotal += item.preco * item.quantidade;
    notifyListeners();
  }

  Future<void> navToCarrinho(BuildContext context) async {
    await Nav.push(context, page: CarrinhoPage(carrinho: carrinho));
  }
}
