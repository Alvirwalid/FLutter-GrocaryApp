import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.btntext,
      this.primary = Colors.white38,
      required this.fct});

  final String btntext;
  final Color primary;
  final Function fct;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: primary),
        onPressed: () {
          fct();
        },
        child: Textwidget(
          text: btntext,
          color: Colors.white,
          textsize: 18,
        ));
  }
}
