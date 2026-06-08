import 'package:yala/domain/either/app_failure.dart';

sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T? response;
  Success(this.response);
}

class Failure<T> extends Result<T> {
  final AppFailure appFailure;
  Failure(this.appFailure);
}