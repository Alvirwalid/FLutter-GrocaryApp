import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/providers/viewprovider.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/heart_widget.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../const/firebaseconst.dart';
import '../providers/cartprovider.dart';
import '../providers/wishlistprovider.dart';
import '../service/utils.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});
  static const routename = '/ProductDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController pricecontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    pricecontroller.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pricecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;
    var productid = Get.arguments;
    var prodProvider = Provider.of<ProductProviders>(context);

    var prodList = prodProvider.findById(productid);

    double usedPrice = prodList.isOnSale ? prodList.salePrice : prodList.price;
    double totalPrice = usedPrice * int.parse(pricecontroller.text);
    final cartProvider = Provider.of<Cartprovider>(context);

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool isWishlist =
        wishlistProvider.getwishlistitems.containsKey(prodList.id);

    final viewProvider = Provider.of<Viewprovider>(context);

    return WillPopScope(
      onWillPop: () async {
        viewProvider.addTohistory(productid);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: const BackWidget(),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl: prodList.imageUrl,
                // height: size.width * 0.22,
                width: size.width,
                boxFit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    //color: Theme.of(context).cardColor,
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, top: 20, right: 25),
                      child: Row(
                        children: [
                          Textwidget(
                            text: prodList.title,
                            color: color,
                            textsize: 20,
                            istitle: true,
                          ),
                          const Spacer(),
                          HeartWidget(
                            productid: prodList.id,
                            isWishlist: isWishlist,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Textwidget(
                            text: prodList.price.toString(),
                            color: Colors.green,
                            textsize: 22,
                            istitle: true,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          prodList.isPieace
                              ? const Text('Piece')
                              : const Text('/kg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Visibility(
                              visible: prodList.isOnSale ? true : false,
                              child: Text(
                                usedPrice.toStringAsFixed(2),
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              )),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Textwidget(
                                  text: 'Free delivery',
                                  color: Colors.white,
                                  textsize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _quantityController(
                          onpressed: () {
                            if (pricecontroller.text == '1') {
                              return;
                            } else {
                              setState(() {
                                pricecontroller.text =
                                    (int.parse(pricecontroller.text) - 1)
                                        .toString();
                              });
                            }
                          },
                          clr: Colors.red,
                          icon: CupertinoIcons.minus_circle,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                            flex: 2,
                            child: SizedBox(
                                width: 50,
                                child: TextField(
                                  onChanged: ((value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        pricecontroller.text = '1';
                                      } else {}
                                    });
                                  }),
                                  key: const ValueKey('quantity'),
                                  keyboardType: TextInputType.number,
                                  controller: pricecontroller,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                  ),
                                  textAlign: TextAlign.center,
                                  cursorColor: Colors.green,
                                  enabled: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ))),
                        const SizedBox(
                          width: 8,
                        ),
                        _quantityController(
                            clr: Colors.green,
                            icon: CupertinoIcons.plus_circle,
                            onpressed: () {
                              setState(() {
                                pricecontroller.text =
                                    (int.parse(pricecontroller.text) + 1)
                                        .toString();
                              });
                            }),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textwidget(
                                    text: 'Total',
                                    color: Colors.red.shade300,
                                    textsize: 20),
                                FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Textwidget(
                                        text:
                                            '${totalPrice.toStringAsFixed(2)}',
                                        color: color,
                                        textsize: 20,
                                        istitle: true,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      prodList.isPieace
                                          ? const Text('Piece')
                                          : Text('${pricecontroller.text}/ kg'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Material(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green,
                            child: InkWell(
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
                                    productid: prodList.id,
                                    quantity: int.parse(pricecontroller.text));
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Textwidget(
                                    text: 'Add to cart',
                                    color: Colors.white,
                                    textsize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _quantityController(
      {required Color clr,
      required IconData icon,
      required Function onpressed}) {
    return Flexible(
      flex: 2,
      child: Material(
        color: clr,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: (() {
              onpressed();
              setState(() {});
            }),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
