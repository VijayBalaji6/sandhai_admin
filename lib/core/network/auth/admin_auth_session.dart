import '../dtos/admin_auth_user.dart';

/// In-memory session for the admin JWT issued by your verify-otp Edge Function.
/// This is separate from [Supabase.auth] (anon session). Use [accessToken] when
/// your API or RLS expects this custom Bearer token.
class AdminAuthSession {
  AdminAuthSession._();

  static String? accessToken;
  static AdminAuthUser? currentUser;

  static bool get isSignedIn =>
      accessToken != null &&
      accessToken!.trim().isNotEmpty &&
      currentUser != null;

  static void setSession({
    required String token,
    required AdminAuthUser user,
  }) {
    accessToken = token.trim();
    currentUser = user;
  }

  static void clear() {
    accessToken = null;
    currentUser = null;
  }
}
