import 'package:comida_ja/app/data/extensions/double_formater.dart';
import 'package:comida_ja/app/modules/restaurante/restaurante_controller.dart';
import 'package:comida_ja/ui/common/shared_styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../ui/common/color_scheme.dart';
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
                    const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("R\$ 0,00"), Text("0 itens")])
                  ],
                ),
              ),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 64.0, right: 64.0, top: 32.0),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.restaurante.nome!,
                                style: bodyLargeColor(AppColors.neutral.white),
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
                                    style:
                                        bodySmallColor(AppColors.neutral.white),
                                  ),
                                  Text(
                                    " • ${widget.restaurante.tipoComida?.titulo} • R\$ ${widget.restaurante.valorEntrega.toFormat_2()}",
                                    style:
                                        bodySmallColor(AppColors.neutral.white),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ...List.generate(controller.itensCardapio.length, (index) {
                    return Container(
                      color: index % 2 == 0
                          ? AppColors.neutral.white
                          : AppColors.neutral.mediumLight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Text(controller.itensCardapio[index].nome ?? '')
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
