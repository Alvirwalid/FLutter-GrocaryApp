import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocaryapp/const/const.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:provider/provider.dart';

import '../models/productmodel.dart';
import '../providers/productprovider.dart';
import '../service/utils.dart';
import '../widget/feed_widget.dart';
import '../widget/textwidhet.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});
  static const routename = '/FeedsScreen';

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose

    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;
    var productProvider = Provider.of<ProductProviders>(context);

    List<ProductModel> productList = productProvider.getProduct;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Textwidget(
          text: 'All Product',
          color: color,
          textsize: 22,
          istitle: true,
        ),
        leading: const BackWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      suffix: IconButton(
                          onPressed: (() {
                            searchController.clear();
                            _focusNode.unfocus();
                          }),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.greenAccent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.greenAccent)),
                      hintText: 'what\'s yor mind',
                      hintStyle: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
            GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.57),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(productList.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productList[index], child: FeedWidget());
              }),
            )
          ],
        ),
      ),
    );
  }
}
