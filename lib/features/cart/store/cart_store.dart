import 'package:flutter/foundation.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/result/result.dart';
import '../data/api/cart_api.dart';
import '../domain/entities/cart.dart';
import '../../products/domain/entities/product.dart';

class CartStore extends ChangeNotifier {
  final CartApi api;
  CartStore({required this.api});

  Cart _cart = Cart();
  bool isLoading = false;
  String? error;

  Cart get cart => _cart;

  void clearError() {
    error = null;
    notifyListeners();
  }

  void add(Product product) {
    try {
      _cart = _cart.add(product);
      error = null;
    } catch (e) {
      error = (e is AppException) ? e.message : 'Ocorreu um erro';
    }
    notifyListeners();
  }

  void decrement(Product product) {
    _cart = _cart.decrement(product);
    error = null;
    notifyListeners();
  }

  Future<void> remove(Product product) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await resultOf(() => api.removeItem(product.id));

    switch (result) {
      case Success():
        _cart = _cart.remove(product);
      case Failure(message: final msg):
        error = msg;
    }

    isLoading = false;
    notifyListeners();
  }

  void clear() {
    _cart = Cart();
    notifyListeners();
  }
}
