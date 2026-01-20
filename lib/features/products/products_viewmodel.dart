import 'package:flutter/foundation.dart';

import '../../data/api/products_api.dart';
import '../../domain/entities/product.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductsApi api;

  ProductsViewModel(this.api);

  bool isLoading = false;
  String? error;
  List<Product> products = [];

  Future<void> loadProducts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      products = await api.fetchProducts();
    } catch (e) {
      error = 'Erro ao carregar produtos';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
