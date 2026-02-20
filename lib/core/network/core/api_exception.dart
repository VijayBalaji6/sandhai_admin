/// Represents an API/network exception with details.
class ApiException {
  const ApiException({
    required this.message,
    this.statusCode,
    this.code,
    this.details,
    this.hint,
    this.originalError,
  });

  final String message;
  final int? statusCode;
  final String? code;
  final String? details;
  final String? hint;
  final Object? originalError;

  bool get isNotFound => statusCode == 404 || code == 'PGRST116';
  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isConflict => statusCode == 409 || code == '23505';
  bool get isNetworkError =>
      statusCode == null && originalError is! FormatException;

  @override
  String toString() =>
      'ApiException('
      'message: $message, '
      'statusCode: $statusCode, '
      'code: $code, '
      'details: $details, '
      'hint: $hint)';
}
