import 'package:comida_ja/app/data/extensions/double_formater.dart';
import 'package:comida_ja/app/data/models/carrinho/carrinho.dart';
import 'package:comida_ja/app/modules/pedido/pedido_controller.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../ui/common/color_scheme.dart';
import '../../../ui/common/shared_styles.dart';
import '../../data/models/item_cardapio/item_cardapio.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key, required this.carrinho});

  final Carrinho carrinho;

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  PedidoController controller = PedidoController();

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
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        color: AppColors.brand.darker,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Acompanhe seu pedido: ",
                                    style:
                                        bodyLargeColor(AppColors.neutral.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.neutral.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Informações do pedido:",
                                style: bodyRegularBold,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      widget.carrinho.itensCarrinho.length ?? 0,
                                  itemBuilder: (context, index) {
                                    ItemCardapio? item =
                                        widget.carrinho.itensCarrinho[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${item.numItems}x ${item.nome}',
                                            style: bodyRegularColor(
                                                AppColors.neutral.medium),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            '- R\$ ${item.preco.toFormat_2()}',
                                            style: bodyRegularColor(
                                                AppColors.neutral.medium),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              Divider(),
                              Text(
                                "Entrega:",
                                style: bodyRegularBold,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
