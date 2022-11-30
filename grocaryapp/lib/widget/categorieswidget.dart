import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

import '../inner_screen/categoryscreen.dart';

class Categorieswidget extends StatelessWidget {
  const Categorieswidget(
      {Key? key,
      required this.cattext,
      required this.imagepath,
      required this.passcolor})
      : super(key: key);
  final String cattext, imagepath;
  final Color passcolor;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    //  final themeState = Provider.of<DarkThemeProvider>(context);
    final utils = Utils(context);
    Color color = utils.colors;

    double screensize = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(title: const Text(''),),
      body: InkWell(
        onTap: (() {
          Get.toNamed(CategoryScreen.routename, arguments: cattext);
        }),
        child: Container(
          decoration: BoxDecoration(
              color: passcolor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 2, color: passcolor.withOpacity(0.7))),
          child: Column(
            children: [
              Container(
                width: screensize * 0.45,
                height: screensize * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(imagepath))),
              ),
              Textwidget(
                text: cattext,
                color: passcolor,
                textsize: 18,
                istitle: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
