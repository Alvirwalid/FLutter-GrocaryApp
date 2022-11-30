import 'package:shared_preferences/shared_preferences.dart';

class DarkthemePrefs {
  static const Theme_Status = 'ThemeStatus';

  Future setDarkTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool(Theme_Status, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(Theme_Status) ?? false;
  }
}
