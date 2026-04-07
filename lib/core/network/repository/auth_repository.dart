import '../auth/admin_auth_session.dart';
import '../../auth/auth_navigation.dart';
import '../core/api_result.dart';
import '../data_source/auth_remote_data_source.dart';
import '../dtos/admin_auth_user.dart';
import '../dtos/auth_verify_result.dart';

/// Admin login via OTP Edge Functions. Only users present in [admin_users]
/// with `is_active` and matching phone can receive/complete OTP (enforced server-side).
class AuthRepository {
  AuthRepository({AuthRemoteDataSource? remote})
    : _remote = remote ?? AuthRemoteDataSource();

  final AuthRemoteDataSource _remote;

  static const String kAdminOtpType = 'admin';

  /// Request OTP for an admin phone number.
  Future<ApiResult<void>> sendAdminOtp(String phone) {
    return _remote.sendOtp(phone: phone, type: kAdminOtpType);
  }

  /// Verify OTP and store [AdminAuthSession] on success.
  Future<ApiResult<AuthVerifyResult>> verifyAdminOtp({
    required String phone,
    required String otp,
  }) async {
    final ApiResult<AuthVerifyResult> result = await _remote.verifyOtp(
      phone: phone,
      otp: otp,
      type: kAdminOtpType,
    );

    return result.when(
      success: (AuthVerifyResult data) {
        AdminAuthSession.setSession(token: data.accessToken, user: data.user);
        notifyAuthNavigationChanged();
        return ApiResult.success(data);
      },
      failure: ApiResult.failure,
    );
  }

  void signOut() {
    AdminAuthSession.clear();
    notifyAuthNavigationChanged();
  }

  String? get accessToken => AdminAuthSession.accessToken;

  AdminAuthUser? get currentAdmin => AdminAuthSession.currentUser;

  bool get isSignedIn => AdminAuthSession.isSignedIn;
}
