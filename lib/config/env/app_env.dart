abstract final class AppEnv {
  /// Enable/disable Firebase init. Example:
  /// `--dart-define=FIREBASE_ENABLED=false`
  static const bool firebaseEnabled =
      bool.fromEnvironment('FIREBASE_ENABLED', defaultValue: true);

  /// Supabase configuration via dart-define (recommended):
  /// `--dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...`
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
}

