import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/inner_screen/producr_detail.dart';
import 'package:grocaryapp/models/cartmodel.dart';
import 'package:grocaryapp/providers/cartprovider.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/heart_widget.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../../models/productmodel.dart';
import '../../providers/wishlistprovider.dart';

class CartWidget extends StatefulWidget {
  CartWidget({Key? key, required this.quantity}) : super(key: key);

  final int quantity;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController quantitytextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    quantitytextController.text = widget.quantity.toString();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    quantitytextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;

    final productProvider = Provider.of<ProductProviders>(context);
    var cartModel = Provider.of<CartModel>(context);

    final getCurrproduct = productProvider.findById(cartModel.productId);

    double usedPrice = getCurrproduct.isOnSale
        ? getCurrproduct.salePrice
        : getCurrproduct.price;
    double totalPrice = usedPrice * int.parse(quantitytextController.text);

    final cartprovider = Provider.of<Cartprovider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool isWishlist =
        wishlistProvider.getwishlistitems.containsKey(getCurrproduct.id);

    return GestureDetector(
      onTap: () {
        Get.toNamed(ProductDetails.routename, arguments: cartModel.productId);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  SizedBox(
                    height: size.width * 0.22,
                    width: size.width * 0.22,
                    child: FancyShimmerImage(
                      imageUrl: getCurrproduct.imageUrl,
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${getCurrproduct.title}",
                        style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Row(
                          children: [
                            _quantityController(
                                clr: Colors.red,
                                icon: CupertinoIcons.minus,
                                onpressed: () {
                                  if (quantitytextController.text == '1') {
                                    return;
                                  } else {
                                    cartprovider
                                        .reduceCartByone(cartModel.productId);
                                    setState(() {
                                      quantitytextController.text = (int.parse(
                                                  quantitytextController.text) -
                                              1)
                                          .toString();
                                    });
                                  }
                                }),
                            Flexible(
                                flex: 2,
                                child: TextField(
                                  controller: quantitytextController,
                                  keyboardType: TextInputType.number,

                                  onChanged: ((value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        quantitytextController.text = '1';
                                      } else {}
                                    });
                                  }),
                                  // ignore: prefer_const_constructors
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(5),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide())),
                                  maxLines: 1,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                )),
                            _quantityController(
                                clr: Colors.green,
                                icon: CupertinoIcons.plus,
                                onpressed: () {
                                  cartprovider
                                      .increaseCartByone(cartModel.productId);
                                  setState(() {
                                    quantitytextController.text = (int.parse(
                                                quantitytextController.text) +
                                            1)
                                        .toString();
                                  });
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // ignore: prefer_const_constructors
                        InkWell(
                          onTap: () {
                            cartprovider.removeCart(cartModel.productId);
                          },
                          child: const Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        HeartWidget(
                          productid: getCurrproduct.id,
                          isWishlist: isWishlist,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Textwidget(
                          text: '${totalPrice.toStringAsFixed(2)}',
                          color: color,
                          textsize: 18,
                          //istitle: true,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
              //setState(() {});
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
