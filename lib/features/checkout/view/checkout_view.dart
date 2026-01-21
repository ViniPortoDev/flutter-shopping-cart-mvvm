import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_shopping_cart_mvvm/app/routes.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/app_card.dart';
import 'package:flutter_shopping_cart_mvvm/design_system/widgets/price_line.dart';
import 'package:flutter_shopping_cart_mvvm/features/checkout/viewmodel/checkout_viewmodel.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CheckoutViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do pedido')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                AppCard(
                  child: Column(
                    children: [
                      PriceLine(
                        label: 'Subtotal',
                        value: 'R\$ ${viewModel.subtotal.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 10),
                      PriceLine(
                        label: 'Frete',
                        value: 'R\$ ${viewModel.freight.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 12),
                      Divider(color: Theme.of(context).dividerColor),
                      const SizedBox(height: 12),
                      PriceLine(
                        label: 'Total',
                        value: 'R\$ ${viewModel.total.toStringAsFixed(2)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SafeArea(
                  top: false,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: viewModel.isLoading
                        ? null
                        : () async {
                            final ok = await viewModel.confirmPayment();

                            if (!context.mounted) return;

                            if (!ok) {
                              final msg = viewModel.error ?? 'Falha ao processar pagamento';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(msg)),
                              );
                              return;
                            }

                            Navigator.pushReplacementNamed(
                              context,
                              Routes.success,
                              arguments: viewModel.freight,
                            );
                          },
                    child: const Text('Confirmar pagamento'),
                  ),
                ),
              ],
            ),
          ),
          if (viewModel.isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
