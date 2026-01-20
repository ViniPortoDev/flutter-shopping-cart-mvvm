import 'package:flutter/material.dart';

import '../features/cart/cart_view.dart';
import '../features/checkout/checkout_success_view.dart';
import '../features/checkout/checkout_view.dart';
import '../features/products/products_view.dart';

class Routes {
  static const products = '/';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const success = '/success';
}

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    Routes.products: (_) => const ProductsView(),
    Routes.cart: (_) => const CartView(),
    Routes.checkout: (_) => const CheckoutView(),
    Routes.success: (_) => const CheckoutSuccessView(),
  };
}
