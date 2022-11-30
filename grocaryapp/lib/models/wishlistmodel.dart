import 'package:flutter/foundation.dart';

class WishlistModel with ChangeNotifier {
  final String id;
  final String productid;

  WishlistModel({required this.id, required this.productid});
}
