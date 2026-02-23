import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class AppBootstrap {
  static Future<void> init() async {
    await _loadEnv();
    // await _initFirebase();
    await _initSupabase();
  }

  /// Loads .env from assets if present. If missing (e.g. 404 on web), env
  /// falls back to dart-defines: --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
  static Future<void> _loadEnv() async {
    const environment = String.fromEnvironment('ENV', defaultValue: 'qa');

    try {
      await dotenv.load(
        fileName: environment == 'prod' ? 'env/prod.env' : 'env/qa.env',
        isOptional: true,
      );

      debugPrint('Loaded environment: $environment');
    } catch (e) {
      debugPrint('Env load failed, using dart-define fallback');
    }
  }

  static Future<void> _initFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e, st) {
      // This allows the app to run even before Firebase is configured
      // (google-services.json / GoogleService-Info.plist / web options).
      debugPrint('Firebase init skipped/failed: $e');
      debugPrintStack(stackTrace: st);
    }
  }

  static Future<void> _initSupabase() async {
    final String supabaseUrl =
        dotenv.env['SUPABASE_URL'] ??
        const String.fromEnvironment('SUPABASE_URL');

    final String supabaseAnonKey =
        dotenv.env['SUPABASE_ANON_KEY'] ??
        const String.fromEnvironment('SUPABASE_ANON_KEY');

    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) return;

    try {
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    } catch (e, st) {
      debugPrint('Supabase init skipped/failed: $e');
      debugPrintStack(stackTrace: st);
    }
  }
}
