import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class EmptyProdScreeen extends StatelessWidget {
  const EmptyProdScreeen({super.key, required this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).colors;
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset('./asset/image/box.png'),
            ),
            Align(
              alignment: Alignment.center,
              child: Textwidget(text: txt, color: color, textsize: 24),
            )
          ],
        ),
      ),
    );
  }
}
