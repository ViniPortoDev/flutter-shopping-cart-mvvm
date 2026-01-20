import 'package:flutter/material.dart';

class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido finalizado'),
      ),
      body: const Center(
        child: Text('Pedido realizado com sucesso'),
      ),
    );
  }
}
