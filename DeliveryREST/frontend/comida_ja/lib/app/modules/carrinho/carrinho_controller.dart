import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';
import 'package:flutter/cupertino.dart';

import '../../data/dependencies/http_app/http_app.dart';
import '../../data/dependencies/navigation/nav.dart';
import '../../data/repositories/carrinho_repository.dart';
import '../pedido/pedido_page.dart';

class CarrinhoController extends ChangeNotifier {
  final CarrinhoRepository repository = CarrinhoRepository(httpApp: HttpApp());

  Future<void> finalizarPedido(Carrinho? carrinho, BuildContext context) async {
    await repository.postCarrinho(carrinho!);
    Nav.push(context,
        page: PedidoPage(
          carrinho: carrinho,
        ));
  }
}
