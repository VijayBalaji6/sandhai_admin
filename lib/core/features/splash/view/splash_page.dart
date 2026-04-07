import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/config/theme/app_colors.dart';
import 'package:sandhai_admin/core/network/auth/admin_auth_session.dart';

import '../../../../config/router/app_routes.dart';
import '../../../../constants/app_strings.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  Future<void> _navigateToDashboard() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    if (AdminAuthSession.isSignedIn) {
      context.go(AppRoutes.products);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.storefront_rounded, size: 80),
            const SizedBox(height: 24),
            Text(AppStrings.appName),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
