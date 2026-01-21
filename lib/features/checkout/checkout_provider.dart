import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'data/api/checkout_api.dart';
import '../cart/store/cart_store.dart';
import 'view/checkout_view.dart';
import 'viewmodel/checkout_viewmodel.dart';

class CheckoutProvider extends StatelessWidget {
  const CheckoutProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckoutViewModel(
        api: CheckoutApi(),
        cartStore: context.read<CartStore>(),
      ),
      child: const CheckoutView(),
    );
  }
}
