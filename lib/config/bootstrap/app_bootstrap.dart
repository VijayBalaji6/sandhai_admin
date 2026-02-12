import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../env/app_env.dart';

abstract final class AppBootstrap {
  static Future<void> init() async {
    await _initFirebase();
    await _initSupabase();
  }

  static Future<void> _initFirebase() async {
    if (!AppEnv.firebaseEnabled) return;
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
    final url = AppEnv.supabaseUrl.trim();
    final anonKey = AppEnv.supabaseAnonKey.trim();
    if (url.isEmpty || anonKey.isEmpty) return;

    try {
      await Supabase.initialize(url: url, anonKey: anonKey);
    } catch (e, st) {
      debugPrint('Supabase init skipped/failed: $e');
      debugPrintStack(stackTrace: st);
    }
  }
}

