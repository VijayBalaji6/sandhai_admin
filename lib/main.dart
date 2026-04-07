import 'package:flutter/material.dart';

import 'app.dart';
import 'config/bootstrap/app_bootstrap.dart';
import 'core/network/core/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.init();
  // Retry init if bootstrap used a different code path; ensures client before UI.
  await SupabaseClientProvider.ensureReady();
  runApp(const SandhaiAdminApp());
}
