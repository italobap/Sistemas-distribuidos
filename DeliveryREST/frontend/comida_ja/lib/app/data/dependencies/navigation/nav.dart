import 'package:flutter/material.dart';

class Nav {
  static void pop<T>(BuildContext context, {T? param}) {
    Navigator.pop(context, param);
  }

  static void maybePop<T>(BuildContext context, {T? param}) {
    Navigator.maybePop(context, param);
  }

  static Future<T?> push<T>(BuildContext context,
      {required Widget page}) async {
    return await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => page,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
      ),
    );
  }

  static void pushRemoveAll(BuildContext context, {required Widget page}) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => page,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future<dynamic> pushRemoveCurrent(BuildContext context,
      {required Widget page}) async {
    return await Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => page,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
      ),
    );
  }
}
