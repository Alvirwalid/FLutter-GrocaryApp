import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/inner_screen/producr_detail.dart';
import 'package:grocaryapp/models/wishlistmodel.dart';
import 'package:grocaryapp/providers/cartprovider.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/providers/wishlistprovider.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/heart_widget.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

class WishlistWedget extends StatelessWidget {
  const WishlistWedget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;

    final prodprovider = Provider.of<ProductProviders>(context);

    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistprovider = Provider.of<WishlistProvider>(context);

    final cartProvider = Provider.of<Cartprovider>(context);

    bool isWishlist =
        wishlistprovider.getwishlistitems.containsKey(wishlistModel.productid);

    final prodlist = prodprovider.findById(wishlistModel.productid);
    return GestureDetector(
      onTap: (() {
        Get.toNamed(ProductDetails.routename,
            arguments: wishlistModel.productid);
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 0.5)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FancyShimmerImage(
                  imageUrl: prodlist.imageUrl,
                  height: size.width * 0.21,
                  width: size.width * 0.2,
                  boxFit: BoxFit.fill,
                ),
                SizedBox(
                  width: 8,
                ),
                FittedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                cartProvider.addCartItems(
                                    productid: wishlistModel.productid,
                                    quantity: 1);
                              },
                              child: Icon(IconlyLight.bag2)),
                          SizedBox(
                            width: 8,
                          ),
                          HeartWidget(
                            productid: wishlistModel.productid,
                            isWishlist: isWishlist,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Textwidget(
                        text: prodlist.title,
                        color: color,
                        textsize: 20,
                        istitle: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Textwidget(
                        text: '\$2.99',
                        color: color,
                        textsize: 20,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    wishlistprovider.removewishList(wishlistModel.productid);
                  },
                  child: const Icon(
                    CupertinoIcons.cart_badge_minus,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
