import 'package:comida_ja/app/data/extensions/double_formater.dart';
import 'package:comida_ja/app/data/models/carrinho/item_carrinho.dart';
import 'package:comida_ja/app/modules/carrinho/carrinho_controller.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../ui/common/color_scheme.dart';
import '../../../ui/common/shared_styles.dart';
import '../../data/dependencies/navigation/nav.dart';
import '../../data/models/carrinho/carrinho.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key, required this.carrinho});

  final Carrinho? carrinho;

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  final CarrinhoController controller = CarrinhoController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (c, w) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(
              MdiIcons.food,
            ),
            backgroundColor: AppColors.neutral.white,
            elevation: 2,
            shape: Border(
                bottom:
                    BorderSide(color: AppColors.neutral.medium, width: 0.6)),
            title: Text(
              "Comida Já",
              style: bodyLarge,
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(MdiIcons.cart),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "R\$ ${widget.carrinho?.precoTotal.toFormat_2() ?? 0.00.toFormat_2()} "),
                          Text(
                              "${widget.carrinho?.itensCarrinho.length ?? 0} itens")
                        ])
                  ],
                ),
              ),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 64.0, right: 64.0, top: 32.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Container(
                  color: AppColors.neutral.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        color: AppColors.brand.darker,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                onTap: () =>
                                    Nav.pop(context, param: widget.carrinho),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: AppColors.neutral.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Text(
                                "Seu Carrinho ",
                                style: bodyLargeColor(AppColors.neutral.white),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Text(
                                "Total: R\$ ${(widget.carrinho!.precoTotal + widget.carrinho!.valorEntrega).toFormat_2()}",
                                style: bodyLargeColor(AppColors.neutral.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.carrinho?.itensCarrinho.length ?? 0,
                          itemBuilder: (context, index) {
                            ItemCarrinho? item =
                                widget.carrinho?.itensCarrinho[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.neutral.mediumLight,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${item?.quantidade}x ${item?.itemCardapio?.nome}',
                                        style: bodyRegular,
                                      ),
                                      Text(
                                        'R\$ ${item?.itemCardapio?.preco.toFormat_2()}',
                                        style: bodyRegularBold,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Subtotal: R\$ ${widget.carrinho?.precoTotal.toFormat_2() ?? "0,00"}",
                              style: bodyRegularColor(AppColors.neutral.medium),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Taxa de Entrega: ${widget.carrinho!.valorEntrega > 0 ? "R\$ ${widget.carrinho?.valorEntrega.toFormat_2() ?? "0,00"}" : "Grátis"}",
                              style: bodyRegularColor(AppColors.neutral.medium),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      controller.finalizarPedido(
                                          widget.carrinho, context);
                                    },
                                    child: const Text("Realizar Pedido")),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
