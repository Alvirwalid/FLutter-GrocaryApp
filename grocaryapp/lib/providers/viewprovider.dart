import 'package:flutter/foundation.dart';
import 'package:grocaryapp/models/viewmodel.dart';

class Viewprovider with ChangeNotifier {
  Map<String, ViewModel> _viewitems = {};
  Map<String, ViewModel> get getviewitems => _viewitems;

  void addTohistory(String productId) {
    _viewitems.putIfAbsent(productId,
        () => ViewModel(id: DateTime.now().toString(), productId: productId));
    notifyListeners();
  }

  void removeHistory(String productId) {
    _viewitems.remove(productId);
    notifyListeners();
  }

  void cleanhistory() {
    _viewitems.clear();
    notifyListeners();
  }
}
