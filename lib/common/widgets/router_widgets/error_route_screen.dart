import 'package:QuIDPe/src/common/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:QuIDPe/src/common/widgets/custom_button/custom_elevated_button.dart';
import 'package:QuIDPe/src/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorRouteScreen extends StatelessWidget {
  const ErrorRouteScreen({super.key, required this.state});
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Error Screen'),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: 'An error occurred while navigating to this Screen.',
            ),
            CustomText(text: 'Error details: '),
            CustomText(text: '${state.error}'),
            CustomText(text: ' ${state.path}'),
            CustomElevatedButton(
              buttonName: "Go Home",
              buttonAction: () => context.goNamed(AppPublicRoutes.splash.name),
            ),
          ],
        ),
      ),
    );
  }
}
