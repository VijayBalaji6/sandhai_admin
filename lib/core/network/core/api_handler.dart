import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sandhai_admin/core/network/core/api_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/utils/network_utils.dart';
import 'api_result.dart';
import 'supabase_client.dart';

abstract final class ApiHandler {
  static Future<ApiResult<T>> guard<T>({
    required String tag,
    required Future<T> Function() action,
    Duration timeout = const Duration(seconds: 30),
    bool checkConnection = true,
  }) async {
    try {
      SupabaseClientProvider.ensureInitialized();
      if (checkConnection) {
        final hasInternet = await NetworkUtils.hasInternetConnection();
        if (!hasInternet) {
          return networkException();
        }
      }
      final T data = await action().timeout(timeout);
      return ApiResult.success(data);
    } on PostgrestException catch (e, st) {
      _logError(tag, 'PostgrestException', e.message, st);
      return postgresException(e);
    } on AuthException catch (e, st) {
      _logError(tag, 'AuthException', e.message, st);
      return getAuthException(e);
    } on SocketException catch (e, st) {
      _logError(tag, 'SocketException', e.toString(), st);
      return getSocketException();
    } on TimeoutException catch (e, st) {
      _logError(tag, 'TimeoutException', e.toString(), st);
      return getTimeoutException();
    } on FormatException catch (e, st) {
      _logError(tag, 'FormatException', e.toString(), st);
      return getFormatException();
    } on StateError catch (e, st) {
      _logError(tag, 'StateError', e.toString(), st);
      return getStateError(e);
    } catch (e, st) {
      _logError(tag, 'Unexpected error', e.toString(), st);
      return getUnknownException(e);
    }
  }

  static void _logError(
    String tag,
    String errorType,
    String message,
    StackTrace st,
  ) {
    debugPrint('[$tag] $errorType: $message');
    debugPrintStack(stackTrace: st);
  }

  static ApiResult<Never> getUnknownException(Object e) {
    return ApiResult.failure(
      ApiException(
        message: 'Something went wrong. Please try again.',
        statusCode: 500,
        code: 'UNKNOWN',
        originalError: e,
      ),
    );
  }

  static ApiResult<Never> getStateError(StateError e) {
    return ApiResult.failure(
      ApiException(
        message: e.message,
        statusCode: 500,
        code: 'SUPABASE_NOT_INITIALIZED',
        originalError: e,
      ),
    );
  }

  static ApiResult<Never> getTimeoutException() {
    return const ApiResult.failure(
      ApiException(
        message: 'Request timed out. Please try again.',
        statusCode: 408,
        code: 'TIMEOUT',
      ),
    );
  }

  static ApiResult<Never> getSocketException() {
    return const ApiResult.failure(
      ApiException(
        message: 'No internet connection. Please check your network.',
        statusCode: 503,
        code: 'NETWORK_ERROR',
      ),
    );
  }

  static ApiResult<Never> getAuthException(AuthException e) {
    return ApiResult.failure(
      ApiException(
        message: e.message,
        statusCode: e.statusCode != null ? int.tryParse(e.statusCode!) : 401,
        code: 'AUTH_ERROR',
        originalError: e,
      ),
    );
  }

  static ApiResult<Never> postgresException(PostgrestException e) {
    return ApiResult.failure(
      ApiException(
        message: _humanMessage(e.code, e.message),
        statusCode: _mapSupabaseCodeToStatusCode(e.code),
        code: e.code,
        details: e.details?.toString(),
        hint: e.hint,
        originalError: e,
      ),
    );
  }

  static ApiResult<Never> networkException() {
    return const ApiResult.failure(
      ApiException(
        message: 'No internet connection. Please check your network.',
        statusCode: 503,
        code: 'NETWORK_ERROR',
      ),
    );
  }

  static ApiResult<Never> getFormatException() {
    return const ApiResult.failure(
      ApiException(
        message: 'Invalid response from server.',
        statusCode: 500,
        code: 'FORMAT_ERROR',
      ),
    );
  }

  static String _humanMessage(String? code, String raw) {
    switch (code) {
      case 'PGRST116':
        return 'Record not found.';
      case '23505':
        return 'This record already exists.';
      case '23503':
        return 'Cannot proceed – a related record is missing.';
      case '23502':
        return 'A required field is missing.';
      case '42501':
        return 'You don\'t have permission for this action.';
      case '42P01':
        return 'The requested resource does not exist.';
      default:
        return raw.isNotEmpty ? raw : 'An unexpected error occurred.';
    }
  }

  static int? _mapSupabaseCodeToStatusCode(String? code) {
    switch (code) {
      case 'PGRST116':
        return 404;
      case '23505':
        return 409;
      case '23503':
      case '23502':
        return 400;
      case '42501':
        return 403;
      case '42P01':
        return 404;
      default:
        return null;
    }
  }
}
