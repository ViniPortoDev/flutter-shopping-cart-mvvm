import 'package:flutter/foundation.dart';

import '../../../core/result/result.dart';
import '../data/api/products_api.dart';
import '../domain/entities/product.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductsApi api;

  ProductsViewModel({required this.api});

  bool isLoading = false;
  String? error;
  List<Product> products = [];

  Future<void> loadProducts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await resultOf(() => api.fetchProducts());

    switch (result) {
      case Success(value: final list):
        products = list;
      case Failure(message: final msg):
        error = msg;
    }

    isLoading = false;
    notifyListeners();
  }
}
