import 'dart:math';

import '../../../../core/errors/app_exception.dart';

class CartApi {
  final _rand = Random();

  Future<void> removeItem(int productId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final fail = _rand.nextInt(4) == 0;
    if (fail) {
      throw const AppException('Erro ao remover item');
    }
  }
}
