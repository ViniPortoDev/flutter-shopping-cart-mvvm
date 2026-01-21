import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/cart/data/api/cart_api.dart';
import '../features/cart/store/cart_store.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CartApi()),
        ChangeNotifierProvider(
          create: (context) => CartStore(api: context.read<CartApi>()),
        ),
      ],
      child: child,
    );
  }
}
