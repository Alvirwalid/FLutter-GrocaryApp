import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocaryapp/service/utils.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;
    return InkWell(
      onTap: (() {
        Navigator.canPop(context) ? Navigator.of(context).pop() : null;
      }),
      child: Icon(
        IconlyLight.arrowLeft2,
        size: 24,
        color: color,
      ),
    );
  }
}
