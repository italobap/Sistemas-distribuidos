import 'package:flutter/material.dart';

class AppSize {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static double size(double size, BuildContext context) =>
      _finalSize(size, context);

  static double _finalSize(double size, BuildContext context) {
    var currentSize = (size / 360) * width(context);
    var minSize = size * 0.8;
    var maxSize = size * 1.2;

    if (currentSize < minSize) {
      return minSize;
    }
    if (currentSize > maxSize) {
      return maxSize;
    }
    return currentSize;
  }
}
