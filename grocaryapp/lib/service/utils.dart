import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/darkthemeprovider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;

  Color get colors => getTheme ? Colors.white : Colors.black;
  Size get screensize => MediaQuery.of(context).size;
}
