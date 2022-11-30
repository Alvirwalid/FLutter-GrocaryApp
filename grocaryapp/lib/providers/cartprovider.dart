import 'package:flutter/cupertino.dart';
import 'package:grocaryapp/models/cartmodel.dart';

class Cartprovider extends ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, CartModel> _cartitems = {};

  Map<String, CartModel> get getCartItems => _cartitems;

  void addCartItems({
    required String productid,
    required int quantity,
  }) {
    _cartitems.putIfAbsent(
        productid,
        () => CartModel(
            id: DateTime.now().toString(),
            productId: productid,
            quantity: quantity));

    notifyListeners();

    print('cartItemsList $_cartitems');
  }

  Map<String, dynamic> get getCartitems {
    return _cartitems;
  }

  void reduceCartByone(String productid) {
    print('updated id =${productid}');
    _cartitems.update(
        productid,
        (value) => CartModel(
            id: value.id, productId: productid, quantity: value.quantity - 1));

    notifyListeners();
  }

  void increaseCartByone(String productid) {
    _cartitems.update(
        productid,
        (value) => CartModel(
            id: value.id, productId: productid, quantity: value.quantity + 1));
    notifyListeners();
  }

  void removeCart(String productId) {
    _cartitems.remove(productId);
    notifyListeners();
  }

  void clearcart() {
    _cartitems.clear();
    notifyListeners();
  }
}
