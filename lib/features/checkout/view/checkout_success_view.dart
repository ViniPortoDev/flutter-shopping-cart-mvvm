import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_shopping_cart_mvvm/app/routes.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/app_card.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/price_line.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/product_card.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/store/cart_store.dart';

class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = context.read<CartStore>();
    final cart = cartStore.cart;

    final args = ModalRoute.of(context)?.settings.arguments;
    final freight = (args is double) ? args : 0.0;

    final subtotal = cart.subtotal;
    final total = subtotal + freight;

    return Scaffold(
      appBar: AppBar(title: const Text('Pedido realizado')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                AppCard(
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 28, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Compra confirmada! Aqui está o resumo do seu pedido.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Itens',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 10),
                ...cart.items.map((item) {
                  final p = item.product;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ProductCard(
                      imageUrl: p.image,
                      title: p.title,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Qtd: ${item.quantity}'),
                          const SizedBox(height: 4),
                          Text('Unitário: R\$ ${p.price.toStringAsFixed(2)}'),
                          const SizedBox(height: 4),
                          Text(
                            'Subtotal: R\$ ${item.subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
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
                    value: 'R\$ ${subtotal.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 6),
                  PriceLine(
                    label: 'Frete',
                    value: 'R\$ ${freight.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 10),
                  PriceLine(
                    label: 'Total',
                    value: 'R\$ ${total.toStringAsFixed(2)}',
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
          ),
        ],
      ),
    );
  }
}
