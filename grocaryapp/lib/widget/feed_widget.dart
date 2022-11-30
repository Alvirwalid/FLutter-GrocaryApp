import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/inner_screen/producr_detail.dart';
import 'package:grocaryapp/models/productmodel.dart';
import 'package:grocaryapp/providers/cartprovider.dart';
import 'package:grocaryapp/providers/viewprovider.dart';
import 'package:grocaryapp/widget/heart_widget.dart';
import 'package:grocaryapp/widget/pricewidget.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../const/firebaseconst.dart';
import '../providers/productprovider.dart';
import '../providers/wishlistprovider.dart';
import '../service/globalmethod.dart';
import '../service/utils.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({
    super.key,
  });

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final pricetextcontroller = TextEditingController();
  String price = '1';
  @override
  void initState() {
    // TODO: implement initState
    pricetextcontroller.text = '1';
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pricetextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;
    final productList = Provider.of<ProductModel>(context);

    final cartProvider = Provider.of<Cartprovider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productList.id);

    final wishlistProvider = Provider.of<WishlistProvider>(context);

    bool isInwishlist =
        wishlistProvider.getwishlistitems.containsKey(productList.id);

    final viewProvider = Provider.of<Viewprovider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Get.toNamed(ProductDetails.routename, arguments: productList.id);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FancyShimmerImage(
                      imageUrl: productList.imageUrl,
                      height: size.width * 0.18,
                      width: size.width,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 3,
                            child: Textwidget(
                              text: productList.title,
                              color: color,
                              textsize: 18,
                              maxline: 1,
                            )),
                        Flexible(
                            flex: 1,
                            child: HeartWidget(
                              productid: productList.id,
                              isWishlist: isInwishlist,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Pricewidget(
                            saleprice: productList.salePrice,
                            price: productList.price,
                            textprice: pricetextcontroller.text,
                            isonsale: true,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: FittedBox(
                                  child: Textwidget(
                                    text: productList.isPieace ? 'Piece' : 'kg',
                                    color: color,
                                    textsize: 20,
                                    istitle: true,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  flex: 2,
                                  // TextField can be used also instead of the textFormField
                                  child: TextFormField(
                                    controller: pricetextcontroller,
                                    key: const ValueKey('10'),
                                    style:
                                        TextStyle(color: color, fontSize: 18),
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    enabled: true,
                                    onChanged: (valueee) {
                                      setState(() {
                                        if (pricetextcontroller.text.isEmpty) {
                                          pricetextcontroller.text = '0';
                                        }
                                      });
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.]'),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: isInCart
                          ? null
                          : () {
                              final User? user = authinstance.currentUser;

                              if (user == null) {
                                GlobalMethod.errorDialog(
                                    ctx: context,
                                    subtitle:
                                        'No user found,Please login first');

                                return;
                              }
                              cartProvider.addCartItems(
                                  productid: productList.id,
                                  quantity:
                                      int.parse(pricetextcontroller.text));
                            },
                      child: Textwidget(
                          text: isInCart ? 'In cart' : 'Add to Cart',
                          color: color,
                          textsize: 18))
                ],
              ),
            )),
      ),
    );
  }
}
