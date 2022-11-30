import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/inner_screen/producr_detail.dart';
import 'package:grocaryapp/models/viewmodel.dart';
import 'package:grocaryapp/providers/cartprovider.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../../const/firebaseconst.dart';
import '../../service/globalmethod.dart';

class viewrecentlywidget extends StatelessWidget {
  const viewrecentlywidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;

    final prodprovider = Provider.of<ProductProviders>(context);
    final viewModel = Provider.of<ViewModel>(context);

    final prodlist = prodprovider.findById(viewModel.productId);

    final usedPrice = prodlist.isOnSale ? prodlist.salePrice : prodlist.price;

    final cartprovider = Provider.of<Cartprovider>(context);

    final isInCart = cartprovider.getCartItems.containsKey(viewModel.productId);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(ProductDetails.routename, arguments: viewModel.productId);
        },
        child: Row(
          children: [
            FancyShimmerImage(
              imageUrl: prodlist.imageUrl,
              height: size.width * 0.22,
              width: size.width * 0.22,
              boxFit: BoxFit.fill,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Textwidget(
                  text: prodlist.title,
                  color: color,
                  textsize: 22,
                  istitle: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Textwidget(
                  text: usedPrice.toStringAsFixed(2),
                  color: color,
                  textsize: 16,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: isInCart
                        ? null
                        : () {
                            final User? user = authinstance.currentUser;

                            if (user == null) {
                              GlobalMethod.errorDialog(
                                  ctx: context,
                                  subtitle: 'No user found,Please login first');

                              return;
                            }
                            cartprovider.addCartItems(
                                productid: viewModel.productId, quantity: 1);
                          },
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        isInCart ? Icons.check : Icons.add,
                        color: Colors.white,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
