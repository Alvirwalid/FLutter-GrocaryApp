import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocaryapp/models/cartmodel.dart';
import 'package:grocaryapp/models/productmodel.dart';
import 'package:grocaryapp/providers/cartprovider.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/screens/cart/cart_widget.dart';
import 'package:grocaryapp/widget/emptycart.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../../service/utils.dart';
import '../../widget/feed_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isempty = true;
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;

    final cartProvider = Provider.of<Cartprovider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();

    //print('cartItemsList ${cartItemsList[0]}');

    return cartItemsList.isEmpty
        ? const EmptyScreen(
            imgpath: 'asset/image/cart.png',
            title: 'Your cart is empty',
            subtitle: 'Add something and make me happy',
            btntext: 'Shop Now',
          )
        : Scaffold(
            appBar: AppBar(
              //leading: const BackWidget(),
              toolbarHeight: 80,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Textwidget(
                  text: 'Cart (${cartItemsList.length})',
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
                            title: 'Empty your cart ?',
                            subtitle: 'Are you sure',
                            onpressed: () {
                              cartProvider.clearcart();
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _checkout(context: context),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        shrinkWrap: true,
                        itemCount: cartItemsList.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: cartItemsList[index],
                              child: CartWidget(
                                quantity: cartItemsList[index].quantity,
                              ));
                          ;
                        }),
                  ),
                ],
              ),
            ));
  }
}

Widget _checkout({required BuildContext context}) {
  final utils = Utils(context);
  Color color = utils.colors;
  Size size = utils.screensize;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    width: double.infinity,
    height: size.width * 0.1,
    child: Row(
      children: [
        Material(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Textwidget(
                text: 'Order Now',
                color: Colors.white,
                textsize: 18,
              ),
            ),
          ),
        ),
        const Spacer(),
        FittedBox(
            child: Textwidget(text: 'Total \$2.56', color: color, textsize: 18))
      ],
    ),
  );
}
