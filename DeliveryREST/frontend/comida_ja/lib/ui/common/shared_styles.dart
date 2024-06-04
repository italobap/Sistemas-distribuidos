import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';

TextStyle get titleText => const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
    );

TextStyle bodySmallColor(Color color) => TextStyle(fontSize: 10, color: color);

TextStyle get bodySmall => const TextStyle(fontSize: 10);

TextStyle get bodyRegular => const TextStyle(fontSize: 16);

TextStyle bodyRegularColor(Color color) =>
    TextStyle(fontSize: 16, color: color);

TextStyle get bodyRegularBold =>
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800);

TextStyle get bodyLarge => const TextStyle(fontSize: 18);

TextStyle get bodyLargeBold =>
    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800);
TextStyle bodyLargeColor(Color color) => TextStyle(fontSize: 18, color: color);
