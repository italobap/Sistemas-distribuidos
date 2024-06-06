import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';
import 'package:flutter/cupertino.dart';

import '../../data/dependencies/http_app/http_app.dart';
import '../../data/dependencies/navigation/nav.dart';
import '../../data/models/pedido/pedido.dart';
import '../../data/repositories/carrinho_repository.dart';
import '../../data/repositories/pedido_repository.dart';
import '../pedido/pedido_page.dart';

class CarrinhoController extends ChangeNotifier {
  final CarrinhoRepository repository = CarrinhoRepository(httpApp: HttpApp());
  final PedidoRepository pedidoRepository = PedidoRepository(httpApp:  HttpApp());

  Future<void> finalizarPedido(Carrinho? carrinho, BuildContext context) async {
    carrinho?.id = await repository.postCarrinho(carrinho);
    Pedido pedido = Pedido(carrinho: carrinho);
    await pedidoRepository.postPedido(pedido);
    Nav.push(context,
        page: PedidoPage(
          pedido: pedido,
        ));


  }
}
