import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/app/routes.dart';
import 'package:provider/provider.dart';

import '../domain/entities/product.dart';
import '../../cart/store/cart_store.dart';
import '../viewmodel/products_viewmodel.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductsViewModel>();
    final cartStore = context.watch<CartStore>();
    final err = cartStore.error;
    if (err != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(err)));
        cartStore.clearError();
      });
    }

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
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, size: 32),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.cart);
                },
              ),
              if (cartStore.cart.totalItems > 0)
                Positioned(
                  right: 6,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartStore.cart.totalItems.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
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
