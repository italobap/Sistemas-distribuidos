import 'package:comida_ja/main.dart';
import 'package:flutter/material.dart';

import '../../data/models/restaurante/restaurante.dart';

class HomeController extends ChangeNotifier {
  bool darkMode = false;

  final List<Restaurante> restaurantes = [];

  void initController() {
    darkMode = false;
    notifyListeners();
  }

  Future<void> getRestaurantes() async {
    for (int i = 0; i <= 8; i++) {}
  }

  void toggleThemeMode(bool value, BuildContext context) {
    darkMode = value;
    if (darkMode) {
      MyApp.of(context).changeTheme(ThemeMode.dark);
    } else {
      MyApp.of(context).changeTheme(ThemeMode.light);
    }
    notifyListeners();
  }
}
