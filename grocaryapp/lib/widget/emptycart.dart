import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grocaryapp/inner_screen/feedsscreen.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key,
      required this.imgpath,
      required this.title,
      required this.subtitle,
      required this.btntext});

  final String imgpath, title, subtitle, btntext;

  @override
  Widget build(BuildContext context) {
    final themeState = Utils(context).getTheme;
    Color color = Utils(context).colors;
    Size size = Utils(context).screensize;
    return Scaffold(
      // extendBody: true,
      extendBodyBehindAppBar: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imgpath,
            width: double.infinity,
            height: size.height * 0.4,
          ),
          const SizedBox(
            height: 10,
          ),
          Textwidget(
            text: 'Whoops!',
            color: Colors.red,
            textsize: 24,
            istitle: true,
          ),
          const SizedBox(
            height: 10,
          ),
          Textwidget(text: title, color: Colors.cyan, textsize: 18),
          const SizedBox(
            height: 10,
          ),
          Textwidget(text: subtitle, color: Colors.cyan, textsize: 18),
          SizedBox(
            height: size.height * 0.1,
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(FeedsScreen.routename);
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  side: BorderSide(color: color),
                  primary: Theme.of(context).colorScheme.secondary,
                  //onPrimary: color,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              child: Textwidget(
                  text: btntext,
                  color:
                      themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                  textsize: 20))
        ],
      ),
    );
  }
}
