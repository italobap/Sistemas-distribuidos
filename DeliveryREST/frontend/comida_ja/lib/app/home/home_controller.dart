import 'package:comida_ja/main.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool darkMode = false;

  void initController() {
    darkMode = false;
    notifyListeners();
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
