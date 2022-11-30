import 'package:flutter/material.dart';

class styles {
  static ThemeData themeData(
      {required bool isdark, required BuildContext context}) {
    return ThemeData(
        scaffoldBackgroundColor: isdark ? Color(0xff00001a) : Color(0xffffffff),
        colorScheme: ThemeData().colorScheme.copyWith(
            secondary: isdark ? Color(0xff1a1f3c) : Color(0xffE8FDFD),
            brightness: isdark ? Brightness.dark : Brightness.light),
        cardColor: isdark ? Color(0xff0a0d2c) : Color(0xfff2FDFD),
        canvasColor: isdark ? Colors.black : Colors.grey[50],
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isdark ? ColorScheme.dark() : ColorScheme.light()));
  }
}
