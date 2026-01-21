import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_shopping_cart_mvvm/app/routes.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/product_card.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/store/cart_store.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/domain/entities/product.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/viewmodel/products_viewmodel.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductsViewModel>();
    final cartStore = context.watch<CartStore>();

    final error = cartStore.error;
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
        cartStore.clearError();
      });
    }

    if (viewModel.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (viewModel.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Produtos')),
        body: Center(child: Text(viewModel.error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          _CartIconWithBadge(
            count: cartStore.cart.totalItems,
            onTap: () => Navigator.pushNamed(context, Routes.cart),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: viewModel.products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, index) {
          final product = viewModel.products[index];
          final inCart = cartStore.cart.contains(product);

          return ProductCard(
            imageUrl: product.image,
            title: product.title,
            subtitle: Text(
              'R\$ ${product.price.toStringAsFixed(2)}',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            trailing: inCart
                ? _QuantityControl(product: product)
                : ElevatedButton.icon(
                    onPressed: () => cartStore.add(product),
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar'),
                  ),
          );
        },
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  final Product product;
  const _QuantityControl({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartStore = context.watch<CartStore>();
    final cart = cartStore.cart;
    final item = cart.items.firstWhere((i) => i.product.id == product.id);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.remove),
            onPressed: () => cartStore.decrement(product),
          ),
          Text(
            item.quantity.toString(),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add),
            onPressed: () => cartStore.add(product),
          ),
        ],
      ),
    );
  }
}

class _CartIconWithBadge extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const _CartIconWithBadge({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(icon: const Icon(Icons.shopping_cart), onPressed: onTap),
        if (count > 0)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
