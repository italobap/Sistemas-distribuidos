import 'dart:html';

import 'package:comida_ja/app/data/enum/enum_status_entrega.dart';
import 'package:comida_ja/app/data/extensions/double_formater.dart';
import 'package:comida_ja/app/data/models/carrinho/item_carrinho.dart'; // import 'package:sse_channel/sse_channel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../ui/common/color_scheme.dart';
import '../../../ui/common/shared_styles.dart';
import '../../data/constantes/url_base.dart';
import '../../data/models/pedido/pedido.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key, required this.pedido});

  final Pedido pedido;

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  @override
  void initState() {
    connectToSse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          MdiIcons.food,
        ),
        backgroundColor: AppColors.neutral.white,
        elevation: 2,
        shape: Border(
            bottom: BorderSide(color: AppColors.neutral.medium, width: 0.6)),
        title: Text(
          "Comida Já",
          style: bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Acompanhe seu pedido: ",
                              style: bodyLargeColor(AppColors.neutral.white),
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
                                widget.pedido.carrinho?.itensCarrinho.length,
                            itemBuilder: (context, index) {
                              ItemCarrinho? item =
                                  widget.pedido.carrinho?.itensCarrinho[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '${item?.quantidade}x ${item?.itemCardapio?.nome}',
                                      style: bodyRegularColor(
                                          AppColors.neutral.medium),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      '- R\$ ${item?.itemCardapio?.preco.toFormat_2()}',
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pedido Enviado"),
                                  Text("Em progresso"),
                                  Text("A caminho"),
                                  Text("Entregue"),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.brand.dark,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: widget.pedido.status.index <
                                                EnumStatusEntrega
                                                    .em_progresso.index
                                            ? AppColors.neutral.mediumLight
                                            : AppColors.brand.dark,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: widget.pedido.status.index <
                                              EnumStatusEntrega
                                                  .em_progresso.index
                                          ? AppColors.neutral.mediumLight
                                          : AppColors.brand.dark,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: widget.pedido.status.index <
                                                EnumStatusEntrega
                                                    .a_caminho.index
                                            ? AppColors.neutral.mediumLight
                                            : AppColors.brand.dark,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: widget.pedido.status.index <
                                              EnumStatusEntrega.a_caminho.index
                                          ? AppColors.neutral.mediumLight
                                          : AppColors.brand.dark,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: widget.pedido.status !=
                                                EnumStatusEntrega.entregue
                                            ? AppColors.neutral.mediumLight
                                            : AppColors.brand.dark,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: widget.pedido.status !=
                                              EnumStatusEntrega.entregue
                                          ? AppColors.neutral.mediumLight
                                          : AppColors.brand.dark,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
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
  }

  void parseSseEvent(Event event) {
    MessageEvent messageEvent = event as MessageEvent;
    setState(() {
      widget.pedido.status = EnumStatusEntrega.values.byName(messageEvent.data);
    });
  }

  Future<void> connectToSse() async {
    String url = UrlBase.getSseUrl();
    final eventSource = EventSource(url);
    eventSource.addEventListener(
        'dataUpdate', (Event event) => parseSseEvent(event));
  }
}
