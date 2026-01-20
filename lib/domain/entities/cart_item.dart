import 'product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  double get subtotal => product.price * quantity;

  CartItem increment() {
    return CartItem(
      product: product,
      quantity: quantity + 1,
    );
  }

  CartItem decrement() {
    return CartItem(
      product: product,
      quantity: quantity - 1,
    );
  }
}
