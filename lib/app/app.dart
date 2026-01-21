import 'package:flutter/material.dart';
import '../design_system/theme/app_theme.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: Routes.products,
      routes: AppRoutes.routes,
    );
  }
}
