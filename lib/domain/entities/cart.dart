import 'cart_item.dart';
import 'product.dart';

class Cart {
  static const maxDifferentProducts = 10;

  final Map<int, CartItem> _items;

  Cart([Map<int, CartItem>? items]) : _items = items ?? {};

  List<CartItem> get items => _items.values.toList();

  int get totalItems =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.values.fold(0, (sum, item) => sum + item.subtotal);

  bool contains(Product product) => _items.containsKey(product.id);

  Cart add(Product product) {
    if (!_items.containsKey(product.id) &&
        _items.length >= maxDifferentProducts) {
      throw Exception('Limite de produtos diferentes atingido');
    }

    final updatedItems = Map<int, CartItem>.from(_items);

    if (updatedItems.containsKey(product.id)) {
      updatedItems[product.id] =
          updatedItems[product.id]!.increment();
    } else {
      updatedItems[product.id] =
          CartItem(product: product, quantity: 1);
    }

    return Cart(updatedItems);
  }

  Cart decrement(Product product) {
    if (!_items.containsKey(product.id)) return this;

    final updatedItems = Map<int, CartItem>.from(_items);
    final item = updatedItems[product.id]!;

    if (item.quantity <= 1) {
      updatedItems.remove(product.id);
    } else {
      updatedItems[product.id] = item.decrement();
    }

    return Cart(updatedItems);
  }

  Cart clear() => Cart();
}
