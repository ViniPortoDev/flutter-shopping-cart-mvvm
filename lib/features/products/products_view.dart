import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/product.dart';
import '../../stores/cart_store.dart';
import 'products_viewmodel.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductsViewModel>();
    final cart = context.watch<CartStore>();

    if (vm.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (vm.error != null) {
      return Scaffold(body: Center(child: Text(vm.error!)));
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
        itemCount: vm.products.length,
        itemBuilder: (_, index) {
          final product = vm.products[index];
          final inCart = cart.contains(product);

          return ListTile(
            leading: Image.network(product.image, width: 50),
            title: Text(product.title),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: inCart
                ? _QuantityControl(product)
                : ElevatedButton(
                    onPressed: () {
                      cart.add(product);
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
    final cart = context.watch<CartStore>();
    final item = cart.cart.items.firstWhere((e) => e.product.id == product.id);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => cart.decrement(product),
        ),
        Text(item.quantity.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => cart.add(product),
        ),
      ],
    );
  }
}
