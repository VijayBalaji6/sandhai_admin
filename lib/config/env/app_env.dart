import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppEnv {
  /// Whether .env was loaded (call AppBootstrap.init() first).
  static bool get isLoaded => dotenv.isInitialized;

  /// Environment flavor. From .env or dart-define ENV (default: qa).
  static String get flavor =>
      _getFromDotenv('ENV', 'qa') ??
      _fromEnvironment('ENV', fallback: 'qa');

  /// Supabase URL. From .env or dart-define SUPABASE_URL.
  static String get supabaseUrl =>
      _getFromDotenv('SUPABASE_URL', '') ??
      _fromEnvironment('SUPABASE_URL', fallback: '');

  /// Supabase anon key. From .env or dart-define SUPABASE_ANON_KEY.
  static String get supabaseAnonKey =>
      _getFromDotenv('SUPABASE_ANON_KEY', '') ??
      _fromEnvironment('SUPABASE_ANON_KEY', fallback: '');

  static String? _getFromDotenv(String key, String emptyFallback) {
    if (!dotenv.isInitialized) return null;
    final value = dotenv.env[key]?.trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  static String _fromEnvironment(String name, {required String fallback}) {
    // dart-define: flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
    final String value = _dartDefineMap[name] ?? fallback;
    return value.trim().isEmpty ? fallback : value;
  }

  static const Map<String, String> _dartDefineMap = {
    'ENV': String.fromEnvironment('ENV', defaultValue: ''),
    'SUPABASE_URL': String.fromEnvironment('SUPABASE_URL', defaultValue: ''),
    'SUPABASE_ANON_KEY':
        String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: ''),
  };
}
