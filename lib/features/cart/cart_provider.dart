import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../data/api/cart_api.dart';
import '../../stores/cart_store.dart';
import 'cart_view.dart';
import 'cart_viewmodel.dart';

class CartProvider extends StatelessWidget {
  const CartProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartViewModel(
        cartStore: context.read<CartStore>(),
        api: CartApi(),
      ),
      child: const CartView(),
    );
  }
}
