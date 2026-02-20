import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'constants/app_strings.dart';

class SandhaiAdminApp extends StatelessWidget {
  const SandhaiAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

