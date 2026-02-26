import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/config/theme/app_colors.dart';

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
    context.go(AppRoutes.products);
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
