import 'dart:math';

class CheckoutApi {
  Future<void> processPayment() async {
    await Future.delayed(const Duration(seconds: 2));

    final success = Random().nextBool();
    if (!success) {
      throw Exception('Pagamento recusado');
    }
  }
}
