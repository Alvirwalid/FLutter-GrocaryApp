import 'package:flutter/cupertino.dart';
import 'package:grocaryapp/models/wishlistmodel.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistitems = {};
  Map<String, WishlistModel> get getwishlistitems {
    return _wishlistitems;
  }

  void addremoveTowishlist(String productid) {
    if (_wishlistitems.containsKey(productid)) {
      removewishList(productid);
    } else {
      _wishlistitems.putIfAbsent(
          productid,
          () => WishlistModel(
              id: DateTime.now().toString(), productid: productid));

      notifyListeners();
    }
  }

  void removewishList(String productId) {
    _wishlistitems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistitems.clear();
    notifyListeners();
  }
}
