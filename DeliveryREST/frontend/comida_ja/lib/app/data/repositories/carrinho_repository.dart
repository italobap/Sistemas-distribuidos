import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';

import '../dependencies/http_app/http_app.dart';

class CarrinhoRepository {
  final IHttpApp httpApp;

  CarrinhoRepository({required this.httpApp});

  Future<void> postCarrinho(Carrinho carrinho) async {}
}
