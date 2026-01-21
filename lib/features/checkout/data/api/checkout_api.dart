import 'dart:math';

import '../../../../core/errors/app_exception.dart';

class CheckoutApi {
  Future<void> processPayment() async {
    await Future.delayed(const Duration(seconds: 2));

    final success = Random().nextBool();
    if (!success) {
      throw const AppException('Falha ao processar pagamento');
    }
  }
}
