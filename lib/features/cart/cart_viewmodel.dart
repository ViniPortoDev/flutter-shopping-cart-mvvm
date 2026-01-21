import 'package:flutter/foundation.dart';

import '../../data/api/cart_api.dart';
import '../../domain/entities/product.dart';
import '../../stores/cart_store.dart';

class CartViewModel extends ChangeNotifier {
  final CartStore cartStore;
  final CartApi api;

  bool isLoading = false;
  String? error;

  CartViewModel({required this.cartStore, required this.api});

  Future<void> remove(Product product) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await api.removeItem();
      cartStore.decrement(product);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
