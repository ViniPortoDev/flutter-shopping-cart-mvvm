import '../features/cart/cart_provider.dart';
import '../features/checkout/checkout_provider.dart';
import '../features/checkout/checkout_success_view.dart';
import '../features/products/products_provider.dart';

class Routes {
  static const products = '/';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const success = '/success';
}

class AppRoutes {
  static final routes = {
    Routes.products: (_) => const ProductsProvider(),
    Routes.cart: (_) => const CartProvider(),
    Routes.checkout: (_) => const CheckoutProvider(),
    Routes.success: (_) => const CheckoutSuccessView(),
  };
}
