import 'package:sandhai_admin/core/network/core/api_exception.dart';

/// Represents the result of an API/network call.
sealed class ApiResult<T> {
  const ApiResult();

  const factory ApiResult.success(T data) = ApiSuccess<T>;
  const factory ApiResult.failure(ApiException exception) = ApiFailure<T>;

  TResult when<TResult>({
    required TResult Function(T data) success,
    required TResult Function(ApiException exception) failure,
  });
}

final class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess(this.data);

  final T data;

  @override
  TResult when<TResult>({
    required TResult Function(T data) success,
    required TResult Function(ApiException exception) failure,
  }) {
    return success(data);
  }
}

final class ApiFailure<T> extends ApiResult<T> {
  const ApiFailure(this.exception);

  final ApiException exception;

  @override
  TResult when<TResult>({
    required TResult Function(T data) success,
    required TResult Function(ApiException exception) failure,
  }) {
    return failure(exception);
  }
}
