import 'package:flutter/foundation.dart';

class ViewModel with ChangeNotifier {
  final String id, productId;

  ViewModel({required this.id, required this.productId});
}
