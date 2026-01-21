import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes.dart';
import '../../stores/cart_store.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<CartStore>();
    final cart = store.cart;

    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cart.items.map((item) {
                      return ListTile(
                        title: Text(item.product.title),
                        subtitle: Text(
                          'Qtd: ${item.quantity} — R\$ ${item.subtotal.toStringAsFixed(2)}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            store.decrement(item.product);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.checkout);
                    },
                    child: const Text('Finalizar compra'),
                  ),
                ),
              ],
            ),
    );
  }
}
