import 'dart:convert';

import 'package:comida_ja/app/data/models/pedido/pedido.dart';

import '../constantes/endpoints.dart';
import '../constantes/url_base.dart';
import '../dependencies/http_app/http_app.dart';

class CarrinhoRepository {
  final IHttpApp httpApp;

  CarrinhoRepository({required this.httpApp});

  Future<Pedido?> postCarrinho(Pedido pedido) async {
    String url = UrlBase.getUrl() + Endpoints.postPedido;
    Map<String, dynamic> jsonSend = pedido.toMap();
    jsonEncode(jsonSend);
    final response = await httpApp.post(url, data: jsonSend);
    return response.fold((l) => (null), (r) => Pedido().fromMap(r));
  }
}
