import 'package:flutter/material.dart';
import 'package:foodreminder/app/themes/preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  MyPreferences myPreferences = MyPreferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    myPreferences.setTheme(value);
    notifyListeners();
  }
}
