import 'package:comida_ja/app/home/home_controller.dart';
import 'package:comida_ja/ui/common/shared_styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../ui/common/color_scheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          MdiIcons.food,
        ),
        backgroundColor: AppColors.brand.dark,
        elevation: 0,
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
          Switch(
            value: homeController.darkMode,
            onChanged: (value) {
              setState(() {
                homeController.toggleThemeMode(value, context);
              });
            },
            trackOutlineColor: WidgetStateProperty.resolveWith(
              (final Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return null;
                }

                return AppColors.brand.light;
              },
            ),
            activeColor: AppColors.neutral.darkest,
            activeTrackColor: AppColors.brand.light,
            inactiveTrackColor: AppColors.brand.light,
            thumbIcon: thumbIcon,
            thumbColor: thumbColor,
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
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
