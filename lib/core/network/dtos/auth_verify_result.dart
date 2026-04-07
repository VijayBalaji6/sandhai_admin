import 'admin_auth_user.dart';

/// Successful verify-otp Edge Function payload.
class AuthVerifyResult {
  const AuthVerifyResult({
    required this.accessToken,
    required this.user,
  });

  final String accessToken;
  final AdminAuthUser user;
}
