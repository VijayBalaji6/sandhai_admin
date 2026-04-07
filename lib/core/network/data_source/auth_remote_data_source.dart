import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../config/env/app_env.dart';
import '../core/api_handler.dart';
import '../core/api_result.dart';
import '../dtos/admin_auth_user.dart';
import '../dtos/auth_verify_result.dart';

/// Calls Supabase Edge Functions for OTP (send + verify). Only phones that exist
/// in [admin_users] (for type `admin`) can complete login — enforced by Edge.
class AuthRemoteDataSource {
  /// Sends a WhatsApp OTP via your Edge Function (MSG91, etc.).
  Future<ApiResult<void>> sendOtp({
    required String phone,
    required String type,
  }) {
    return ApiHandler.guard(
      tag: 'auth.sendOtp',
      action: () async {
        final FunctionResponse response =
            await Supabase.instance.client.functions.invoke(
          AppEnv.supabaseFnSendOtp,
          body: <String, dynamic>{
            'phone': phone.trim(),
            'type': type,
          },
        );

        _ensure2xx(response, 'send-otp');
        return;
      },
    );
  }

  /// Verifies OTP and returns your custom JWT + [AdminAuthUser].
  Future<ApiResult<AuthVerifyResult>> verifyOtp({
    required String phone,
    required String otp,
    required String type,
  }) {
    return ApiHandler.guard(
      tag: 'auth.verifyOtp',
      action: () async {
        final FunctionResponse response =
            await Supabase.instance.client.functions.invoke(
          AppEnv.supabaseFnVerifyOtp,
          body: <String, dynamic>{
            'phone': phone.trim(),
            'otp': otp.trim(),
            'type': type,
          },
        );

        _ensure2xx(response, 'verify-otp');

        final Map<String, dynamic> json = _asJsonMap(response.data);
        final String? token = json['access_token'] as String?;
        final Object? userRaw = json['user'];
        if (token == null || token.isEmpty) {
          throw StateError('Invalid response: missing access_token');
        }
        if (userRaw is! Map) {
          throw StateError('Invalid response: missing user');
        }

        final AdminAuthUser user = AdminAuthUser.fromJson(
          Map<String, dynamic>.from(userRaw),
        );

        return AuthVerifyResult(accessToken: token, user: user);
      },
    );
  }

  void _ensure2xx(FunctionResponse response, String label) {
    final int status = response.status;
    if (status >= 200 && status < 300) {
      return;
    }
    final String message = _messageFromBody(response.data);
    throw StateError(message.isNotEmpty ? message : '$label failed ($status)');
  }

  String _messageFromBody(Object? data) {
    if (data is Map && data['error'] != null) {
      return data['error'].toString();
    }
    return '';
  }

  Map<String, dynamic> _asJsonMap(Object? data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    throw const FormatException('Expected JSON object from Edge Function');
  }
}
