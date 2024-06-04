import 'package:comida_ja/ui/common/color_scheme.dart';
import 'package:flutter/material.dart';

class ItemButton extends StatefulWidget {
  ItemButton(
      {super.key,
      required this.numItems,
      required this.onTapAdd,
      required this.onTapSub});

  int numItems;
  VoidCallback onTapAdd;
  VoidCallback onTapSub;

  @override
  State<ItemButton> createState() => _ItemButtonState();
}

class _ItemButtonState extends State<ItemButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => widget.numItems > 1 ? widget.onTapSub() : null,
          child: Text('-',
              style: widget.numItems > 1
                  ? TextStyle(color: AppColors.brand.darkest)
                  : TextStyle(color: AppColors.brand.darkest.withOpacity(0.5))),
        ),
        const SizedBox(width: 10),
        Text('${widget.numItems}',
            style: TextStyle(color: AppColors.neutral.darkest)),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => widget.onTapAdd(),
          child: Text('+', style: TextStyle(color: AppColors.brand.darkest)),
        ),
      ],
    );
  }
}
