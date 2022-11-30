import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocaryapp/screens/order/orderwidget.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/emptycart.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routename = '/OrderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;
    Size size = utils.screensize;
    bool isEmpty = true;
    if (isEmpty == true) {
      return EmptyScreen(
          imgpath: 'asset/image/cart.png',
          title: 'You didn\'t place any order yet',
          subtitle: 'Order something and make me happy :',
          btntext: 'Shop now');
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Textwidget(
              text: 'Your orders (0)',
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
                        onpressed: () {});
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
          width: double.infinity,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return const OrderWidget();
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                );
              },
              itemCount: 5),
        ),
      );
    }
  }
}
