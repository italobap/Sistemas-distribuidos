import 'package:flutter/material.dart';

class AppColors {
  const AppColors();

  static const _Brand brand = _Brand();
  static const _Neutral neutral = _Neutral();
  static const _Warning warning = _Warning();
  static const _Status status = _Status();

  // static const _Highlight highlight = _Highlight();
  static const _Gradients gradients = _Gradients();
}

class _Brand {
  const _Brand();

  final Color darkest = const Color(0xffff5722);
  final Color darker = const Color(0xffff7043);
  final Color dark = const Color(0xffff8a65);
  final Color medium = const Color(0xffffab91);
  final Color light = const Color(0xffffccbc);
}

class _Neutral {
  const _Neutral();

  final Color black = const Color(0xff000000);
  final Color darkest = const Color(0xff2E2E3A);
  final Color darker = const Color(0xff333D47);
  final Color dark = const Color(0xff69747B);
  final Color mediumDark = const Color(0xff828D8C);
  final Color medium = const Color(0xff9E9E9E);
  final Color mediumLight = const Color(0xffE8E8E8);
  final Color light = const Color(0xffF3F2F1);
  final Color lighter = const Color(0xffF5F5F5);
  final Color lightest = const Color(0xffFCFCFC);
  final Color white = const Color(0xffFFFFFF);
}

class _Warning {
  const _Warning();

  final Color success = const Color(0xff43A047);
  final Color error = const Color(0xffD32F2F);
  final Color alert = const Color(0xffFDDC02);
  final Color info = const Color(0xff1875D0);
}

class _Status {
  const _Status();

  final Color darkBlue = const Color(0xff4665d2);
  final Color blue = const Color(0xff3a88fd);
  final Color darkGreen = const Color(0xff2d99a8);
  final Color green = const Color(0xff65ad4c);
  final Color lightGreen = const Color(0xff45d5c5);
  final Color yellow = const Color(0xfff3c96d);
  final Color orange = const Color(0xffeb8b4f);
  final Color brown = const Color(0xffaa764d);
  final Color red = const Color(0xffd64343);
  final Color pink = const Color(0xffe87395);
  final Color purple = const Color(0xffb14f9a);
  final Color violet = const Color(0xff762ead);
  final Color gray = const Color(0xff6c757d);
}

// class _Highlight {
//   const _Highlight();
//   final Color darker = const Color(0xffA53403);
//   final Color dark = const Color(0xffDA5D02);
//   final Color medium = const Color(0xffFF6D00);
//   final Color light = const Color(0xffFFB17B);
//   final Color lighter = const Color(0xffFFE6D4);
// }

class _Gradients {
  const _Gradients();

  final LinearGradient $01 = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xffD3F0EB),
      Color(0xffFFFFFF),
    ],
  );

  final LinearGradient $02 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffE8E8E8),
      Color(0xffFFFFFF),
    ],
  );

  final LinearGradient $03 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffff8a65),
      Color(0xffff5722),
    ],
  );

  final LinearGradient $04 = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xffff7043),
      Color.fromRGBO(216, 216, 216, 0.8),
      Color.fromRGBO(255, 255, 255, 1),
    ],
  );
}
