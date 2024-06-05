import 'package:comida_ja/app/data/dependencies/http_app/http_app.dart';
import 'package:comida_ja/app/data/dependencies/navigation/nav.dart';
import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';
import 'package:comida_ja/app/data/repositories/restaurante_repository.dart';
import 'package:comida_ja/app/modules/restaurante/restaurante_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/carrinho/item_carrinho.dart';
import '../../data/models/restaurante/restaurante.dart';

class HomeController extends ChangeNotifier {
  RestauranteRepository repository = RestauranteRepository(httpApp: HttpApp());

  List<Restaurante> restaurantes = [];
  List<String> imagePaths = [];
  Carrinho? carrinho;
  int totalItens = 0;

  Future<void> initController() async {
    carrinho = Carrinho();
    await getRestaurantes();
    notifyListeners();
  }

  Future<void> getRestaurantes() async {
    restaurantes = await repository.getRestaurantes();
  }

  void navToCarrinhoPage() {}

  Future<void> navToRestaurantePage(
      Restaurante item, BuildContext context) async {
    carrinho = await Nav.push(context,
        page: RestaurantePage(
          restaurante: item,
        ));
    notifyListeners();
  }

  void calcTotalItens() {
    totalItens = 0;
    for (ItemCarrinho item in carrinho!.itensCarrinho) {
      totalItens += item.quantidade;
    }
  }
}
