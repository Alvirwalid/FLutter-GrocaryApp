import 'package:flutter/material.dart';
import 'package:grocaryapp/models/productmodel.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/emptyprdwidget.dart';
import 'package:grocaryapp/widget/feed_widget.dart';
import 'package:grocaryapp/widget/onsalewidget.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../service/utils.dart';

class OnsaleScreen extends StatefulWidget {
  const OnsaleScreen({super.key});
  static const routename = '/OnsaleScreen';

  @override
  State<OnsaleScreen> createState() => _OnsaleScreenState();
}

class _OnsaleScreenState extends State<OnsaleScreen> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;

    var productProvider = Provider.of<ProductProviders>(context);

    List<ProductModel> productList =
        Provider.of<ProductProviders>(context).getProductOnSale;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Textwidget(
            text: 'Product on Sale',
            color: color,
            textsize: 22,
            istitle: true,
          ),
          leading: const BackWidget(),
        ),
        body: productList.isEmpty
            ? const EmptyProdScreeen(
                txt: 'No product on sale yet!\n Stay tuned')
            : GridView.count(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: size.width / (size.height * 0.57),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(productList.length, (index) {
                  return ChangeNotifierProvider.value(
                      value: productList[index], child: Onsalewidget());
                }),
              ));
  }
}
