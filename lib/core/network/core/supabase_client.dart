import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../config/env/app_env.dart';

abstract final class SupabaseClientProvider {
  /// Returns the current Supabase client instance.
  static SupabaseClient get client => Supabase.instance.client;

  /// Returns the Supabase URL from environment/config.
  static String get supabaseUrl => AppEnv.supabaseUrl;

  /// Returns the Supabase anon key from environment/config.
  static String get supabaseAnonKey => AppEnv.supabaseAnonKey;

  /// Returns true if Supabase is initialized and ready.
  static bool get isInitialized {
    try {
      final url = AppEnv.supabaseUrl.trim();
      final key = AppEnv.supabaseAnonKey.trim();
      if (url.isEmpty || key.isEmpty) {
        return false;
      }
      Supabase.instance.client;
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Throws if Supabase is not initialized. Call at the start of any API call.
  static void ensureInitialized() {
    if (!isInitialized) {
      final url = AppEnv.supabaseUrl;
      final key = AppEnv.supabaseAnonKey;
      throw StateError(
        'Supabase is not initialized.\n'
        'Call AppBootstrap.init() before API calls.\n'
        'Current config: SUPABASE_URL="$url", SUPABASE_ANON_KEY="${key.isNotEmpty ? "***" : ""}"',
      );
    }
  }

  /// (Optional) Re-initialize Supabase client (for hot reload/dev scenarios).
  static Future<void> reinitialize() async {
    final url = AppEnv.supabaseUrl.trim();
    final key = AppEnv.supabaseAnonKey.trim();
    if (url.isEmpty || key.isEmpty) {
      throw StateError(
        'Cannot reinitialize Supabase: URL or anon key is empty.',
      );
    }
    await Supabase.initialize(url: url, anonKey: key);
  }
}
