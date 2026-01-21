import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_shopping_cart_mvvm/app/routes.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/price_line.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/product_card.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/store/cart_store.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = context.watch<CartStore>();
    final cart = cartStore.cart;

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

    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Stack(
        children: [
          if (cart.items.isEmpty)
            const Center(child: Text('Seu carrinho está vazio'))
          else
            Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final item = cart.items[index];
                      final p = item.product;

                      return ProductCard(
                        imageUrl: p.image,
                        title: p.title,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Unitário: R\$ ${p.price.toStringAsFixed(2)}'),
                            const SizedBox(height: 4),
                            Text(
                              'Subtotal: R\$ ${item.subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        icon: const Icon(Icons.remove),
                                        onPressed: () => cartStore.decrement(p),
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        icon: const Icon(Icons.add),
                                        onPressed: () => cartStore.add(p),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  tooltip: 'Remover',
                                  onPressed: () => cartStore.remove(p),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 12,
                          offset: Offset(0, -2),
                          color: Colors.black12,
                        ),
                      ],
                      border: Border(
                        top: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PriceLine(
                          label: 'Subtotal',
                          value: 'R\$ ${cart.subtotal.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 6),
                        PriceLine(
                          label: 'Total',
                          value: 'R\$ ${cart.subtotal.toStringAsFixed(2)}',
                          bold: true,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: cart.items.isEmpty
                              ? null
                              : () => Navigator.pushNamed(
                                  context,
                                  Routes.checkout,
                                ),
                          child: const Text('Ir para pagamento'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          if (cartStore.isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
