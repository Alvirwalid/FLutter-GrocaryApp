import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;
    return ListTile(
      title: Textwidget(
        text: 'Title x12',
        color: color,
        textsize: 18,
        istitle: true,
      ),
      leading: FancyShimmerImage(
        imageUrl:
            'https://www.pngmart.com/files/15/Apricot-Fruit-Slice-PNG-Transparent-Image.png',
        height: size.width * 0.22,
        width: size.width * 0.22,
        boxFit: BoxFit.fill,
      ),
      trailing: Textwidget(text: '03/08/2022', color: color, textsize: 18),
    );
    ;
  }
}
