import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/product.dart';
import '../../stores/cart_store.dart';
import 'products_viewmodel.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductsViewModel>();
    final cartStore = context.watch<CartStore>();

    if (viewModel.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (viewModel.error != null) {
      return Scaffold(body: Center(child: Text(viewModel.error!)));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.products.length,
        itemBuilder: (_, index) {
          final product = viewModel.products[index];
          final inCart = cartStore.cart.contains(product);

          return ListTile(
            leading: Image.network(product.image, width: 50),
            title: Text(product.title),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: inCart
                ? _QuantityControl(product)
                : ElevatedButton(
                    onPressed: () {
                      cartStore.add(product);
                    },
                    child: const Text('Adicionar'),
                  ),
          );
        },
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  final Product product;

  const _QuantityControl(this.product);

  @override
  Widget build(BuildContext context) {
    final cartStore = context.watch<CartStore>();
    final cart = cartStore.cart;

    final item = cart.items.firstWhere((item) => item.product.id == product.id);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => cartStore.decrement(product),
        ),
        Text(item.quantity.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => cartStore.add(product),
        ),
      ],
    );
  }
}
