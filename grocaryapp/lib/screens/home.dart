import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/const/const.dart';
import 'package:grocaryapp/models/productmodel.dart';
import 'package:grocaryapp/provider/darkthemeprovider.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../inner_screen/feedsscreen.dart';
import '../inner_screen/onsale_screens.dart';
import '../widget/feed_widget.dart';
import '../widget/onsalewidget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  static const routename = '/Homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> imglist = [
    {'imagepath': './asset/image/landing/buy-on-laptop.jpg'},
    {'imagepath': './asset/image/landing/buy-through.png'},
    {'imagepath': './asset/image/landing/buyfood.jpg'},
    {'imagepath': './asset/image/landing/grocery-cart.jpg'},
    {'imagepath': './asset/image/landing/store.jpg'},
    {'imagepath': './asset/image/landing/vergtablebg.jpg'},
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;

    var productProvider = Provider.of<ProductProviders>(context);

    List<ProductModel> productList =
        Provider.of<ProductProviders>(context).getProduct;
    List<ProductModel> productOnSale =
        Provider.of<ProductProviders>(context).getProductOnSale;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.33,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      Constss.offerList[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: Constss.offerList.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.red)),
                  // control: const SwiperControl(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(OnsaleScreen.routename);
                  },
                  child: Textwidget(
                      text: 'View All', color: Colors.blue, textsize: 20)),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Row(
                      children: [
                        Textwidget(
                            text: 'On Sale'.toUpperCase(),
                            color: Colors.red,
                            textsize: 22),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(IconlyLight.discount)
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: size.height * 0.24,
                      child: ListView.separated(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: productOnSale.length,
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              width: 8,
                            );
                          },
                          itemBuilder: ((context, index) {
                            return ChangeNotifierProvider.value(
                                value: productOnSale[index],
                                child: const Onsalewidget());
                          })),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textwidget(
                    text: 'Our Product',
                    color: color,
                    textsize: 20,
                    istitle: true,
                  ),
                  TextButton(
                      onPressed: (() {
                        Get.toNamed(FeedsScreen.routename);
                        print('Browse all');
                      }),
                      child: Textwidget(
                          text: 'Browse all',
                          color: Colors.blue,
                          textsize: 20)),
                ],
              ),
              GridView.count(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: size.width / (size.height * 0.60),
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
      ),
    );
  }
}
