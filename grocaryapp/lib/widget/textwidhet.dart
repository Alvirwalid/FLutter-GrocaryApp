import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Textwidget extends StatelessWidget {
  Textwidget(
      {super.key,
      required this.text,
      required this.color,
      required this.textsize,
      this.istitle = false,
      this.fw,
      this.maxline = 10});

  String text;
  Color color;
  double textsize;
  bool istitle;
  int maxline;
  FontWeight? fw;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: textsize,
          fontWeight: istitle ? FontWeight.bold : FontWeight.normal),
    );
  }
}
