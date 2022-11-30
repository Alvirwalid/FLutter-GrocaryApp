import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/providers/wishlistprovider.dart';
import 'package:grocaryapp/screens/wishlist/wishlist_widget.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/emptycart.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../../service/globalmethod.dart';
import '../../service/utils.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  static const routename = '/WishlistScreen';

  @override
  State<WishlistScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistitems =
        wishlistProvider.getwishlistitems.values.toList().reversed.toList();

    //final prodprovider = Provider.of<ProductProviders>(context);

    /// final prodList=prodprovider.

    if (wishlistitems.isEmpty) {
      return const EmptyScreen(
          imgpath: 'asset/image/wishlist.png',
          title: 'Your Wishlist is Empty',
          subtitle: 'Explore more and shortlist some items ',
          btntext: 'Add a wish');
    } else {
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            leading: const BackWidget(),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Textwidget(
                text: 'Whislist (${wishlistitems.length})',
                color: color,
                textsize: 20,
                istitle: true),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: (() {
                      GlobalMethod.warningDialog(
                          ctx: context,
                          title: 'Empty your Wishlist ?',
                          subtitle: 'Are you sure',
                          onpressed: () {
                            wishlistProvider.clearWishlist();
                          });
                    }),
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    )),
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: MasonryGridView.count(
              itemCount: wishlistitems.length,
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistitems[index], child: const WishlistWedget());
              },
            ),
          ));
    }
    ;
  }
}
