import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class SupabaseClientProvider {
  static SupabaseClient get client => Supabase.instance.client;

  static bool get isInitialized {
    try {
      Supabase.instance.client;
      return true;
    } catch (_) {
      return false;
    }
  }

  static void ensureInitialized() {
    if (!isInitialized) {
      throw StateError(
        'Supabase is not initialized. Call AppBootstrap.init() before API calls.',
      );
    }
  }
}
