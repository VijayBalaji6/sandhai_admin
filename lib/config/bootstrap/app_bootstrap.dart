import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sandhai_admin/config/env/app_env.dart';
import 'package:sandhai_admin/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class AppBootstrap {
  static Future<void> init() async {
    await _loadEnv();
  }

  /// Loads `.env` files from assets (merged). Order: shared [qa] base, then
  /// flavor file [ENV]. So `ENV=dev` still picks up `env/qa.env` when `dev.env`
  /// is missing. Final values also come from `--dart-define` via [AppEnv].
  static Future<void> _loadEnv() async {
    const String environment = String.fromEnvironment(
      'ENV',
      defaultValue: 'qa',
    );

    try {
      // Merge: later loads override earlier keys (flutter_dotenv merges).
      await dotenv.load(fileName: 'env/qa.env', isOptional: true);
      await dotenv.load(fileName: 'env/dev.env', isOptional: true);
      await dotenv.load(fileName: 'env/prod.env', isOptional: true);
      await dotenv.load(fileName: 'env/$environment.env', isOptional: true);

      await _initFirebase();
      await _initSupabase();

      final bool hasSupabase = AppEnv.supabaseUrl.trim().isNotEmpty &&
          AppEnv.supabaseAnonKey.trim().isNotEmpty;
      debugPrint(
        'SandhaiAdmin: ENV=$environment, supabaseConfigured=$hasSupabase',
      );
      if (!hasSupabase) {
        debugPrint(
          'SandhaiAdmin: Missing SUPABASE_URL / SUPABASE_ANON_KEY. '
          'Copy env/qa.env.example to env/qa.env (or set --dart-define).',
        );
      }
    } catch (e, st) {
      debugPrint('Env load failed: $e');
      debugPrintStack(stackTrace: st);
    }
  }

  static Future<void> _initFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e, st) {
      // This allows the app to run even before Firebase is configured
      // (google-services.json / GoogleService-Info.plist / web options).
      debugPrint('Firebase init skipped/failed: $e');
      debugPrintStack(stackTrace: st);
    }
  }

  static Future<void> _initSupabase() async {
    // Same values as [AppEnv] after dotenv load (single source of truth).
    final String supabaseUrl = AppEnv.supabaseUrl.trim();
    final String supabaseAnonKey = AppEnv.supabaseAnonKey.trim();

    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      return;
    }

    try {
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    } catch (e, st) {
      debugPrint('Supabase init skipped/failed: $e');
      debugPrintStack(stackTrace: st);
    }
  }
}
