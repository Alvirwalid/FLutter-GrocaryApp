import 'package:flutter/foundation.dart';
import 'package:grocaryapp/service/darktheme.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkthemePrefs darkthemePrefs = DarkthemePrefs();
  bool _darkTheme = false;

  set setDarKTheme(bool value) {
    _darkTheme = value;
    darkthemePrefs.setDarkTheme(value);
    notifyListeners();
  }

  get getDarkTheme => _darkTheme;
}
