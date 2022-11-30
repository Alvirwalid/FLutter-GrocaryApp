import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/categorieswidget.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map<String, dynamic>> cat = [
    {
      'cattext': 'Fruits',
      'imagepath': './asset/image/cat/fruits.png',
      'color': Colors.red
    },
    {
      'cattext': 'Nuts',
      'imagepath': './asset/image/cat/nuts.png',
      'color': Colors.yellow
    },
    {
      'cattext': 'Grains',
      'imagepath': './asset/image/cat/grains.png',
      'color': Colors.pink
    },
    {
      'cattext': 'Herbs',
      'imagepath': './asset/image/cat/Spinach.png',
      'color': Colors.teal
    },
    {
      'cattext': 'Vegetable',
      'imagepath': './asset/image/cat/veg.png',
      'color': Colors.cyan
    },
    {
      'cattext': 'Spicy',
      'imagepath': './asset/image/cat/spices.png',
      'color': Colors.purple
    },
    {
      'cattext': 'Fruits',
      'imagepath': './asset/image/cat/fruits.png',
      'color': Colors.red
    },
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Textwidget(text: 'Category', color: color, textsize: 24),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(7, (index) {
              return Categorieswidget(
                cattext: cat[index]['cattext'],
                imagepath: cat[index]['imagepath'],
                passcolor: cat[index]['color'],
              );
            })),
      ),
    );
  }
}
