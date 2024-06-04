import 'dart:math';

import 'package:comida_ja/app/data/dependencies/http_app/http_app.dart';
import 'package:comida_ja/app/data/dependencies/navigation/nav.dart';
import 'package:comida_ja/app/data/enum/enum_tipo_restaurante.dart';
import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';
import 'package:comida_ja/app/data/repositories/restaurante_repository.dart';
import 'package:comida_ja/app/modules/restaurante/restaurante_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/restaurante/restaurante.dart';

class HomeController extends ChangeNotifier {
  RestauranteRepository repository = RestauranteRepository(httpApp: HttpApp());

  final List<Restaurante> restaurantes = [];
  List<String> imagePaths = [];
  Carrinho? carrinho;

  Future<void> initController() async {
    carrinho = Carrinho();
    await getRestaurantes();
    notifyListeners();
  }

  Future<void> getRestaurantes() async {
    var rnd = Random();
    for (int i = 0; i < 8; i++) {
      restaurantes.add(
        Restaurante(
          nome: "Teste $i",
          tipoComida:
              EnumTipoComida.values[rnd.nextInt(EnumTipoComida.values.length)],
          valorAvaliacao: rnd.nextDouble() * 5,
          valorEntrega: rnd.nextDouble() * 10,
        ),
      );
    }
    notifyListeners();
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
}
