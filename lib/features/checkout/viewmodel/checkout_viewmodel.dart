import 'package:flutter/foundation.dart';

import '../data/api/checkout_api.dart';
import '../../cart/store/cart_store.dart';

class CheckoutViewModel extends ChangeNotifier {
  final CheckoutApi api;
  final CartStore cartStore;

  bool isLoading = false;
  String? error;
  bool success = false;

  CheckoutViewModel({
    required this.api,
    required this.cartStore,
  });

  Future<void> checkout() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await api.processPayment();
      success = true;
      cartStore.clear();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
