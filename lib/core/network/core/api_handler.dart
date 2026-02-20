import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
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
        final bool hasInternet = await NetworkUtils.hasInternetConnection();
        if (!hasInternet) {
          return ApiResult.failure(
            const ApiException(
              message: 'No internet connection. Please check your network.',
              statusCode: 503,
              code: 'NETWORK_ERROR',
            ),
          );
        }
      }

      final data = await action().timeout(timeout);
      return ApiResult.success(data);
    } on PostgrestException catch (e, st) {
      debugPrint('[$tag] PostgrestException: ${e.message}');
      debugPrintStack(stackTrace: st);
      final int? mappedStatusCode = _mapSupabaseCodeToStatusCode(e.code);
      return ApiResult.failure(
        ApiException(
          message: _humanMessage(e.code, e.message),
          statusCode: mappedStatusCode,
          code: e.code,
          details: e.details?.toString(),
          hint: e.hint,
          originalError: e,
        ),
      );
    } on AuthException catch (e, st) {
      debugPrint('[$tag] AuthException: ${e.message}');
      debugPrintStack(stackTrace: st);
      return ApiResult.failure(
        ApiException(
          message: e.message,
          statusCode: e.statusCode != null ? int.tryParse(e.statusCode!) : 401,
          code: 'AUTH_ERROR',
          originalError: e,
        ),
      );
    } on SocketException catch (e, st) {
      debugPrint('[$tag] SocketException: $e');
      debugPrintStack(stackTrace: st);
      return ApiResult.failure(
        const ApiException(
          message: 'No internet connection. Please check your network.',
          statusCode: 503,
          code: 'NETWORK_ERROR',
        ),
      );
    } on TimeoutException catch (e, st) {
      debugPrint('[$tag] TimeoutException: $e');
      debugPrintStack(stackTrace: st);
      return ApiResult.failure(
        const ApiException(
          message: 'Request timed out. Please try again.',
          statusCode: 408,
          code: 'TIMEOUT',
        ),
      );
    } on FormatException catch (e, st) {
      debugPrint('[$tag] FormatException: $e');
      debugPrintStack(stackTrace: st);
      return ApiResult.failure(
        const ApiException(
          message: 'Invalid response from server.',
          statusCode: 500,
          code: 'FORMAT_ERROR',
        ),
      );
    } on StateError catch (e, st) {
      debugPrint('[$tag] StateError: $e');
      debugPrintStack(stackTrace: st);
      return ApiResult.failure(
        ApiException(
          message: e.message,
          statusCode: 500,
          code: 'SUPABASE_NOT_INITIALIZED',
          originalError: e,
        ),
      );
    } catch (e, st) {
      debugPrint('[$tag] Unexpected error: $e');
      debugPrintStack(stackTrace: st);
      return ApiResult.failure(
        ApiException(
          message: 'Something went wrong. Please try again.',
          statusCode: 500,
          code: 'UNKNOWN',
          originalError: e,
        ),
      );
    }
  }

  static String _humanMessage(String? code, String raw) => switch (code) {
    'PGRST116' => 'Record not found.',
    '23505' => 'This record already exists.',
    '23503' => 'Cannot proceed – a related record is missing.',
    '23502' => 'A required field is missing.',
    '42501' => 'You don\'t have permission for this action.',
    '42P01' => 'The requested resource does not exist.',
    _ => raw.isNotEmpty ? raw : 'An unexpected error occurred.',
  };

  static int? _mapSupabaseCodeToStatusCode(String? code) => switch (code) {
    'PGRST116' => 404,
    '23505' => 409,
    '23503' => 400,
    '23502' => 400,
    '42501' => 403,
    '42P01' => 404,
    _ => null,
  };
}
