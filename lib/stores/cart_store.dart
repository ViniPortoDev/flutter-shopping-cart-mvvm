import 'package:flutter/foundation.dart';
import '../domain/entities/cart.dart';
import '../domain/entities/product.dart';

class CartStore extends ChangeNotifier {
  Cart _cart = Cart();

  Cart get cart => _cart;

  int get totalItems => _cart.totalItems;
  double get subtotal => _cart.subtotal;
  bool contains(Product product) => _cart.contains(product);

  void add(Product product) {
    try {
      _cart = _cart.add(product);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void decrement(Product product) {
    _cart = _cart.decrement(product);
    notifyListeners();
  }

  void clear() {
    _cart = _cart.clear();
    notifyListeners();
  }
}
