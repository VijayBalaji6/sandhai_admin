import 'package:flutter/material.dart';

import 'app.dart';
import 'config/bootstrap/app_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.init();
  runApp(const SandhaiAdminApp());
}
