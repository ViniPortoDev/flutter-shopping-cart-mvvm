import 'dart:math';

class CartApi {
  Future<void> removeItem() async {
    await Future.delayed(const Duration(seconds: 1));

    final shouldFail = Random().nextBool();
    if (shouldFail) {
      throw Exception('Erro ao remover item do carrinho');
    }
  }
}
