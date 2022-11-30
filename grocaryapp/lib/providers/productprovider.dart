import 'package:flutter/cupertino.dart';

import '../models/productmodel.dart';

class ProductProviders with ChangeNotifier {
  List<ProductModel> get getProduct {
    return productList;
  }

  List<ProductModel> get getProductOnSale {
    return productList.where((element) => element.isOnSale == true).toList();
  }

  ProductModel findById(String productId) {
    return productList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    return productList
        .where((element) =>
            element.productCateogoryName.toLowerCase() ==
            categoryName.toLowerCase())
        .toList();
  }

  final List<ProductModel> productList = [
    ProductModel(
      id: 'Potato',
      title: 'Potato',
      price: 0.99,
      salePrice: 0.59,
      imageUrl: 'https://i.ibb.co/wRgtW55/Potato.png',
      productCateogoryName: 'Vegetables',
      isOnSale: true,
      isPieace: false,
    ),
    ProductModel(
      id: 'Radish',
      title: 'Radish',
      price: 0.99,
      salePrice: 0.79,
      imageUrl: 'https://i.ibb.co/YcN4ZsD/Radish.png',
      productCateogoryName: 'Vegetables',
      isOnSale: false,
      isPieace: false,
    ),
    ProductModel(
      id: 'Red peppers',
      title: 'Red peppers',
      price: 0.99,
      salePrice: 0.57,
      imageUrl: 'https://i.ibb.co/JthGdkh/Red-peppers.png',
      productCateogoryName: 'Spicy',
      isOnSale: false,
      isPieace: false,
    ),
    ProductModel(
      id: 'Squash',
      title: 'Squash',
      price: 3.99,
      salePrice: 2.99,
      imageUrl: 'https://i.ibb.co/p1V8sq9/Squash.png',
      productCateogoryName: 'Vegetables',
      isOnSale: true,
      isPieace: true,
    ),
    ProductModel(
      id: 'Tomatoes',
      title: 'Tomatoes',
      price: 0.99,
      salePrice: 0.39,
      imageUrl: 'https://i.ibb.co/PcP9xfK/Tomatoes.png',
      productCateogoryName: 'Vegetables',
      isOnSale: true,
      isPieace: false,
    ),
    // Grains
    ProductModel(
      id: 'Corn-cobs',
      title: 'Corn-cobs',
      price: 0.29,
      salePrice: 0.19,
      imageUrl: 'https://i.ibb.co/8PhwVYZ/corn-cobs.png',
      productCateogoryName: 'Grains',
      isOnSale: false,
      isPieace: true,
    ),
    ProductModel(
      id: 'Peas',
      title: 'Peas',
      price: 0.99,
      salePrice: 0.49,
      imageUrl: 'https://i.ibb.co/7GHM7Dp/peas.png',
      productCateogoryName: 'Grains',
      isOnSale: false,
      isPieace: false,
    ),
    // Herbs
    ProductModel(
      id: 'Asparagus',
      title: 'Asparagus',
      price: 6.99,
      salePrice: 4.99,
      imageUrl: 'https://i.ibb.co/RYRvx3W/Asparagus.png',
      productCateogoryName: 'Herbs',
      isOnSale: false,
      isPieace: false,
    ),
    ProductModel(
      id: 'Brokoli',
      title: 'Brokoli',
      price: 0.99,
      salePrice: 0.89,
      imageUrl: 'https://i.ibb.co/KXTtrYB/Brokoli.png',
      productCateogoryName: 'Herbs',
      isOnSale: true,
      isPieace: true,
    ),
    ProductModel(
      id: 'Buk-choy',
      title: 'Buk-choy',
      price: 1.99,
      salePrice: 0.99,
      imageUrl: 'https://i.ibb.co/MNDxNnm/Buk-choy.png',
      productCateogoryName: 'Herbs',
      isOnSale: true,
      isPieace: true,
    ),
    ProductModel(
      id: 'Chinese-cabbage-wombok',
      title: 'Chinese-cabbage',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'https://i.ibb.co/7yzjHVy/Chinese-cabbage-wombok.png',
      productCateogoryName: 'Herbs',
      isOnSale: false,
      isPieace: true,
    ),
    ProductModel(
      id: 'Kangkong',
      title: 'Kangkong',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'https://i.ibb.co/HDSrR2Y/Kangkong.png',
      productCateogoryName: 'Fruits',
      isOnSale: false,
      isPieace: true,
    ),
    ProductModel(
      id: 'Leek',
      title: 'Leek',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'https://i.ibb.co/Pwhqkh6/Leek.png',
      productCateogoryName: 'Herbs',
      isOnSale: false,
      isPieace: true,
    ),
    ProductModel(
      id: 'Spinach',
      title: 'Spinach',
      price: 0.89,
      salePrice: 0.59,
      imageUrl: 'https://i.ibb.co/bbjvgcD/Spinach.png',
      productCateogoryName: 'Herbs',
      isOnSale: true,
      isPieace: true,
    ),
    ProductModel(
      id: 'Almond',
      title: 'Almond',
      price: 8.99,
      salePrice: 6.5,
      imageUrl: 'https://i.ibb.co/c8QtSr2/almand.jpg',
      productCateogoryName: 'Nuts',
      isOnSale: true,
      isPieace: false,
    ),
  ];
}
