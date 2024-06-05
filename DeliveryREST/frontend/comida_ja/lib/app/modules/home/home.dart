import 'package:comida_ja/app/data/extensions/double_formater.dart';
import 'package:comida_ja/app/data/extensions/string_formater.dart';
import 'package:comida_ja/ui/common/custom_widgets/hover_button.dart';
import 'package:comida_ja/ui/common/shared_styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../ui/common/color_scheme.dart';
import '../../data/models/restaurante/restaurante.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();

  @override
  void initState() {
    homeController.initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: homeController,
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
                                "R\$ ${homeController.carrinho?.precoTotal.toFormat_2() ?? "0,00"} "),
                            Text(
                                "${homeController.carrinho?.itensCarrinho.length ?? 0} itens")
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: AppSize.size(112, context), right: 64.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Hamburguer",
                  //         style: bodyRegular,
                  //       ),
                  //       SizedBox(
                  //         width: AppSize.size(72, context),
                  //       ),
                  //       Text(
                  //         "Pizza",
                  //         style: bodyRegular,
                  //       ),
                  //       const SizedBox(
                  //         width: 74,
                  //       ),
                  //       Text(
                  //         "Doces & Bolos",
                  //         style: bodyRegular,
                  //       ),
                  //       const SizedBox(
                  //         width: 60,
                  //       ),
                  //       Text(
                  //         "Japonesa",
                  //         style: bodyRegular,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 64.0,
                      vertical: 24.0,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      // decoration: BoxDecoration(
                      //     border: Border(
                      //         top: BorderSide(
                      //             color: AppColors.neutral.medium,
                      //             width: 0.6))),
                      child: GridView.builder(
                          padding: const EdgeInsets.all(16.0),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 25.0,
                                  childAspectRatio: 1.8,
                                  crossAxisSpacing: 25.0),
                          itemCount: homeController.restaurantes.length,
                          itemBuilder: (context, index) {
                            Restaurante item =
                                homeController.restaurantes[index];
                            return HoverButton(
                              onTap: () => homeController.navToRestaurantePage(
                                  item, context),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: AppColors.brand.medium,
                                      ),
                                      child: Center(
                                        child: Text(
                                          ' ${item.nome!.getInitials()}',
                                          style: bodyLarge,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.nome ?? "",
                                          style: bodyRegularBold,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              MdiIcons.star,
                                              size: 10,
                                              color: AppColors.status.yellow,
                                            ),
                                            Text(
                                              "${item.valorAvaliacao.toFormat_1()} ",
                                              style: bodySmallColor(
                                                  AppColors.status.yellow),
                                            ),
                                            Text(
                                              " • ${item.tipoComida?.titulo} • ${item.valorEntrega != 0 ? "R\$ ${item.valorEntrega.toFormat_2()}" : "Grátis"}",
                                              style: bodySmall,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(Icons.light_mode);
    },
  );

  final WidgetStateProperty<Color?> thumbColor =
      WidgetStateProperty.resolveWith<Color?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.neutral.white;
      }
      return AppColors.neutral.white;
    },
  );
}
