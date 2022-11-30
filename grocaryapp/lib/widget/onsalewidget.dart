import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/models/cartmodel.dart';
import 'package:grocaryapp/models/productmodel.dart';
import 'package:grocaryapp/providers/cartprovider.dart';
import 'package:grocaryapp/providers/wishlistprovider.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../const/firebaseconst.dart';
import '../inner_screen/producr_detail.dart';
import '../providers/viewprovider.dart';
import '../service/globalmethod.dart';
import 'heart_widget.dart';
import 'pricewidget.dart';

class Onsalewidget extends StatelessWidget {
  const Onsalewidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;

    final productList = Provider.of<ProductModel>(context);

    final cartProvider = Provider.of<Cartprovider>(context);
    bool isInCart = cartProvider.getCartItems.containsKey(productList.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    bool isWishlist =
        wishlistProvider.getwishlistitems.containsKey(productList.id);

    final viewProvider = Provider.of<Viewprovider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.toNamed(ProductDetails.routename, arguments: productList.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FancyShimmerImage(
                      imageUrl: productList.imageUrl,
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        Textwidget(
                          text: productList.isPieace ? 'Piece' : 'kg',
                          color: color,
                          textsize: 20,
                          istitle: true,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: (() {
                                  final User? user = authinstance.currentUser;

                                  if (user == null) {
                                    GlobalMethod.errorDialog(
                                        ctx: context,
                                        subtitle:
                                            'No user found,Please login first');

                                    return;
                                  }

                                  cartProvider.addCartItems(
                                      productid: productList.id, quantity: 1);
                                }),
                                child: Icon(
                                  isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                  color: isInCart ? Colors.green : null,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            HeartWidget(
                              productid: productList.id,
                              isWishlist: isWishlist,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Pricewidget(
                  isonsale: true,
                  price: productList.price,
                  saleprice: productList.salePrice,
                  textprice: '1',
                ),
                SizedBox(
                  height: 8,
                ),
                Textwidget(
                  text: productList.title,
                  color: color,
                  textsize: 16,
                  istitle: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
