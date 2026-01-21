import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'data/api/products_api.dart';
import 'view/products_view.dart';
import 'viewmodel/products_viewmodel.dart';

class ProductsProvider extends StatelessWidget {
  const ProductsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsViewModel(api: ProductsApi())..loadProducts(),
      child: const ProductsView(),
    );
  }
}
