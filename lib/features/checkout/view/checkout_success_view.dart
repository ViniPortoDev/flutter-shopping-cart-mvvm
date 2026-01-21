import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes.dart';
import '../../cart/store/cart_store.dart';

class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = context.read<CartStore>();
    final cart = cartStore.cart;

    final freightArg = ModalRoute.of(context)?.settings.arguments;
    final freight = (freightArg is double) ? freightArg : 0.0;

    final subtotal = cart.subtotal;
    final total = subtotal + freight;

    return Scaffold(
      appBar: AppBar(title: const Text('Pedido realizado')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo do pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final item = cart.items[index];
                  final p = item.product;

                  return ListTile(
                    leading: Image.network(
                      p.image,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(
                      p.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unitário: R\$ ${p.price.toStringAsFixed(2)}'),
                        Text('Subtotal: R\$ ${item.subtotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: Text('${item.quantity}x'),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('R\$ ${subtotal.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Frete'),
                Text('R\$ ${freight.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('R\$ ${total.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                cartStore.clear();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.products,
                  (_) => false,
                );
              },
              child: const Text('Novo pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
