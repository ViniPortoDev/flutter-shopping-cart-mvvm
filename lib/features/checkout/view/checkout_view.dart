import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart/store/cart_store.dart';
import '../../../app/routes.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = context.watch<CartStore>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: cartStore.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('Confirmar pagamento'),
                onPressed: () async {
                  final success = await cartStore.checkout();

                  if (!success) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(cartStore.error!)));
                    return;
                  }

                  Navigator.pushReplacementNamed(context, Routes.success);
                },
              ),
      ),
    );
  }
}
