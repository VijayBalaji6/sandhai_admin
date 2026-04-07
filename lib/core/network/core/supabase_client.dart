import 'package:flutter/foundation.dart';
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
      final String url = AppEnv.supabaseUrl.trim();
      final String key = AppEnv.supabaseAnonKey.trim();
      if (url.isEmpty || key.isEmpty) {
        return false;
      }
      Supabase.instance.client;
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Loads env in [AppBootstrap.init], then call this so [AppEnv] and Supabase
  /// use the same URL/key. Safe to call multiple times.
  ///
  /// If URL/key are missing, returns without throwing (client stays uninitialized).
  static Future<void> ensureReady() async {
    if (isInitialized) {
      return;
    }
    final String url = AppEnv.supabaseUrl.trim();
    final String key = AppEnv.supabaseAnonKey.trim();
    if (url.isEmpty || key.isEmpty) {
      return;
    }
    try {
      await Supabase.initialize(url: url, anonKey: key);
    } catch (e, st) {
      if (isInitialized) {
        return;
      }
      debugPrint('Supabase.initialize failed: $e');
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  /// Use before network calls: ensures lazy init, then validates configuration.
  static Future<void> ensureReadyForApi() async {
    await ensureReady();
    if (!isInitialized) {
      throw StateError(
        'Supabase is not configured. Add SUPABASE_URL and SUPABASE_ANON_KEY '
        'to env/qa.env (or prod.env) or pass '
        '--dart-define=SUPABASE_URL=... and --dart-define=SUPABASE_ANON_KEY=...',
      );
    }
  }

  /// Throws if Supabase is not initialized (sync check only).
  static void ensureInitialized() {
    if (!isInitialized) {
      throw StateError(
        'Supabase is not initialized. Configure credentials or call ensureReady().',
      );
    }
  }

  /// (Optional) Re-initialize Supabase client (for hot reload/dev scenarios).
  static Future<void> reinitialize() async {
    final String url = AppEnv.supabaseUrl.trim();
    final String key = AppEnv.supabaseAnonKey.trim();
    if (url.isEmpty || key.isEmpty) {
      throw StateError(
        'Cannot reinitialize Supabase: URL or anon key is empty.',
      );
    }
    await Supabase.initialize(url: url, anonKey: key);
  }
}
