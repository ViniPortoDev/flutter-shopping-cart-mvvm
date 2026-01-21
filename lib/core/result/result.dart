import '../errors/app_exception.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}

Future<Result<T>> resultOf<T>(Future<T> Function() fn) async {
  try {
    final value = await fn();
    return Success<T>(value);
  } catch (e) {
    if (e is AppException) return Failure<T>(e.message);
    return Failure<T>('Ocorreu um erro');
  }
}
