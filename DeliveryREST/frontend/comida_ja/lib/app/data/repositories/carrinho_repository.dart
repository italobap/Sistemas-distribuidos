import 'dart:convert';

import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';

import '../constantes/endpoints.dart';
import '../constantes/url_base.dart';
import '../dependencies/http_app/http_app.dart';

class CarrinhoRepository {
  final IHttpApp httpApp;

  CarrinhoRepository({required this.httpApp});

  Future<int?> postCarrinho(Carrinho carrinho) async {
    String url = UrlBase.getUrl() + Endpoints.postCarrinho;
    Map<String, dynamic> jsonSend = carrinho.toMap();
    jsonEncode(jsonSend);
    final response = await httpApp.post(url, data: jsonSend);
    return response.fold((l) => (null), (r) => r['cart_id']);
  }
}
