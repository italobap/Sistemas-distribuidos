import 'package:comida_ja/app/data/dependencies/http_app/http_app.dart';
import 'package:comida_ja/app/data/models/item_cardapio/item_cardapio.dart';
import 'package:comida_ja/app/data/models/restaurante/restaurante.dart';

import '../constantes/endpoints.dart';
import '../constantes/url_base.dart';

class RestauranteRepository {
  final IHttpApp httpApp;

  RestauranteRepository({required this.httpApp});

  Future<List<Restaurante>> getRestaurantes() async {
    String url = UrlBase.getApiUrl() + Endpoints.getRestaurantes;
    final response = await httpApp.get(url);
    return response.fold(
        (l) => ([]),
        (r) => (List<Restaurante>.from(
            (r as List).map((x) => Restaurante().fromMap(x)))));
  }

  Future<List<ItemCardapio>> getCardapio(int idRestaurante) async {
    String url = UrlBase.getApiUrl() + Endpoints.getCardapio(idRestaurante);
    final response = await httpApp.get(url);
    return response.fold(
        (l) => ([]),
        (r) => (List<ItemCardapio>.from(
            (r as List).map((x) => ItemCardapio().fromMap(x)))));
  }
}
