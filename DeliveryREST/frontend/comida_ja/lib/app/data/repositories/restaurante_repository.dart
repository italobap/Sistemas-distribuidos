import 'package:comida_ja/app/data/dependencies/http_app/http_app.dart';
import 'package:comida_ja/app/data/models/restaurante/restaurante.dart';

import '../constantes/endpoints.dart';
import '../constantes/url_base.dart';

class RestauranteRepository {
  final IHttpApp httpApp;

  RestauranteRepository({required this.httpApp});

  Future<List<Restaurante>> getRestaurantes() async {
    String url = UrlBase.getUrl() + Endpoints.getRestaurantes;
    final response = await httpApp.get(url);
    return response.fold(
        (l) => ([]),
        (r) => (List<Restaurante>.from(
            (r as List).map((x) => Restaurante().fromMap(x)))));
  }
}
