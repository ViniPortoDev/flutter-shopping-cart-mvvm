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
            const SizedBox(height: 16),
            ...cart.items.map(
              (item) => Text('${item.quantity}x ${item.product.title}'),
            ),
            const Divider(),
            Text(
              'Total: R\$ ${cart.totalItems.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                cartStore.clear();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.products,
                  (_) => false,
                );
              },
              child: const Text('Voltar para loja'),
            ),
          ],
        ),
      ),
    );
  }
}
