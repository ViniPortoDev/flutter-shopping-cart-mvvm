import 'package:flutter/foundation.dart';

import '../domain/entities/cart.dart';
import '../domain/entities/product.dart';

class CartStore extends ChangeNotifier {
  Cart _cart = Cart();
  bool isLoading = false;
  String? error;

  Cart get cart => _cart;

  void add(Product product) {
    _cart = _cart.add(product);
    notifyListeners();
  }

  void decrement(Product product) {
    _cart = _cart.decrement(product);
    notifyListeners();
  }

  Future<bool> checkout() async {
    isLoading = true;
    error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    final success = DateTime.now().millisecondsSinceEpoch % 2 == 0;

    if (!success) {
      error = 'Falha ao processar pagamento';
      isLoading = false;
      notifyListeners();
      return false;
    }

    isLoading = false;
    notifyListeners();
    return true;
  }

  void clear() {
    _cart = Cart();
    notifyListeners();
  }
}
