import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCateogoryName;
  final double price, salePrice;
  final bool isOnSale, isPieace;

  ProductModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCateogoryName,
      required this.price,
      required this.salePrice,
      required this.isOnSale,
      required this.isPieace});
}
