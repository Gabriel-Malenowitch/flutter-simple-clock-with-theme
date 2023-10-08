import 'package:flutter/material.dart';

class AppStore extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void handleToggleTheme(ThemeMode? value) {
    if (value != null) {
      themeMode = value;
      notifyListeners();
    }
  }
}
