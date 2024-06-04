import 'package:comida_ja/app/data/extensions/double_formater.dart';
import 'package:comida_ja/app/data/models/item_cardapio/item_cardapio.dart';
import 'package:comida_ja/app/modules/restaurante/restaurante_controller.dart';
import 'package:comida_ja/ui/common/custom_widgets/item_button.dart';
import 'package:comida_ja/ui/common/shared_styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../ui/common/color_scheme.dart';
import '../../data/dependencies/navigation/nav.dart';
import '../../data/models/restaurante/restaurante.dart';

class RestaurantePage extends StatefulWidget {
  const RestaurantePage({super.key, required this.restaurante});

  final Restaurante restaurante;

  @override
  State<RestaurantePage> createState() => _RestaurantePageState();
}

class _RestaurantePageState extends State<RestaurantePage> {
  final controller = RestauranteController();

  @override
  void initState() {
    controller.initController(widget.restaurante);
    super.initState();
  }

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
                              "R\$ ${controller.carrinho?.precoTotal.toFormat_2() ?? 0.00.toFormat_2()} "),
                          Text(
                              "${controller.carrinho?.itensCarrinho.length ?? 0} itens")
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                                  Nav.pop(context, param: controller.carrinho),
                              child: Icon(
                                Icons.chevron_left,
                                color: AppColors.neutral.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.restaurante.nome!,
                                  style:
                                      bodyLargeColor(AppColors.neutral.white),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MdiIcons.star,
                                      size: 10,
                                      color: AppColors.status.yellow,
                                    ),
                                    Text(
                                      "${widget.restaurante.valorAvaliacao.toFormat_1()} ",
                                      style: bodySmallColor(
                                          AppColors.neutral.white),
                                    ),
                                    Text(
                                      " • ${widget.restaurante.tipoComida?.titulo} • R\$ ${widget.restaurante.valorEntrega.toFormat_2()}",
                                      style: bodySmallColor(
                                          AppColors.neutral.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: AppColors.neutral.white,
                      child: GridView.builder(
                          padding: const EdgeInsets.all(16.0),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.0,
                                  childAspectRatio: 1 / .3,
                                  crossAxisSpacing: 16.0),
                          itemCount: controller.itensCardapio.length,
                          itemBuilder: (context, index) {
                            ItemCardapio item = controller.itensCardapio[index];
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: AppColors.neutral.mediumLight)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.nome ?? "",
                                            style: bodyLargeBold,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Flexible(
                                            child: Text(
                                              item.descricao ?? "",
                                              style: bodyRegularColor(
                                                  AppColors.neutral.medium),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Spacer(),
                                        Row(
                                          children: [
                                            ItemButton(
                                              numItems: item.numItems,
                                              onTapAdd: () => setState(() {
                                                item.numItems++;
                                              }),
                                              onTapSub: () => setState(() {
                                                item.numItems--;
                                              }),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            ElevatedButton(
                                                onPressed: () => controller
                                                    .addCarrinho(item),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Text("Adicionar"),
                                                    const SizedBox(width: 24),
                                                    Text(
                                                      "R\$ ${item.preco.toFormat_2()}",
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
