import 'dart:math';
import 'package:flutter/foundation.dart';

import '../../../core/result/result.dart';
import '../data/api/checkout_api.dart';
import '../../cart/store/cart_store.dart';

class CheckoutViewModel extends ChangeNotifier {
  final CheckoutApi api;
  final CartStore cartStore;

  CheckoutViewModel({required this.api, required this.cartStore});

  bool isLoading = false;
  String? error;

  double freight = 0;

  double get subtotal => cartStore.cart.subtotal;
  double get total => subtotal + freight;

  void init() {
    if (freight != 0) return;
    freight = 10 + Random().nextInt(21).toDouble();
    notifyListeners();
  }

  Future<bool> confirmPayment() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await resultOf(() => api.processPayment());

    switch (result) {
      case Success():
        isLoading = false;
        notifyListeners();
        return true;
      case Failure(message: final msg):
        error = msg;
        isLoading = false;
        notifyListeners();
        return false;
    }
  }
}
