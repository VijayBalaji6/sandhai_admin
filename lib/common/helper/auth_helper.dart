import 'package:QuIDPe/src/config/router/app_routes.dart';
import 'package:QuIDPe/src/core/data/dtos/response/auth/auth_check_response.dart';
import 'package:QuIDPe/src/core/data/dtos/response/retailer/retailer_status_response.dart';
import 'package:QuIDPe/src/core/data/dtos/response/retailer/retailer_validate_response.dart';
import 'package:QuIDPe/src/core/domain/repo_provider/auth/auth_provider.dart';
import 'package:QuIDPe/src/core/services/local_database/shared_preference_services.dart';
import 'package:QuIDPe/src/providers/retailer/retailer_status_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthHelper {
  // Check if user has stored login information
  static bool getIsLogin() => SharedPreferenceService.getBool('is_logged_in');

  // Check if retailer is whitelisted
  static bool getIsWhitelisted() =>
      SharedPreferenceService.getBool('is_retailer_whitelisted');

  static Future<bool> checkAuth(WidgetRef ref) async {
    try {
      final AuthCheckResponse authCheckResponse = await ref
          .read(authRepoProvider)
          .checkAuth();
      return authCheckResponse.authenticated;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkValidateRetailerStatus(WidgetRef ref) async {
    final RetailerValidateResponse? validatedRetailerStatus = await ref
        .read(retailerStatusProvider.notifier)
        .validateRetailer();

    return (validatedRetailerStatus?.isRetailerWhitelisted ?? false);
  }

  static Future<RetailerStatusResponse?> getRetailerStatus(
    WidgetRef ref,
  ) async {
    final RetailerStatusResponse? retailerStatus = await ref
        .read(retailerStatusProvider.notifier)
        .fetchRetailerStatus();

    return retailerStatus;
  }

  static Future<String> getNavigationByRetailerStatus({
    required RetailerStatusResponse retailerStatus,
  }) async {
    switch (retailerStatus.navigateTo?.toUpperCase()) {
      case 'TERM_LOAN_THANK_YOU':
        return AppCommonRoutes.thankYou.name;
      case 'INVOICE_FINANCING':
        return AppScfRoutes.scfHome.name;
      case 'TERM_LOAN':
        return AppTermLoanRoutes.termLoanHome.name;
      default:
        return AppScfRoutes.scfHome.name;
    }
  }

  static Future<String> getUserNavigationByStatus(WidgetRef ref) async {
    // Check Retailer Status and Navigate Accordingly
    final RetailerStatusResponse? retailerStatus =
        await AuthHelper.getRetailerStatus(ref);

    if (retailerStatus?.isRetailerWhitelisted ?? false) {
      final String getNavigationRoute =
          await AuthHelper.getNavigationByRetailerStatus(
            retailerStatus: retailerStatus!,
          );

      return getNavigationRoute;
    } else {
      if (retailerStatus?.isOnboardingRequested ?? false) {
        // Navigate to Onboarding Soon Page
        return AppCommonRoutes.thankYou.name;
      } else {
        return await finalUserNavigationRoute(ref);
      }
    }
  }

  static Future<String> finalUserNavigationRoute(WidgetRef ref) async {
    final bool isValidRetailer = await AuthHelper.checkValidateRetailerStatus(
      ref,
    );
    if (isValidRetailer) {
      final RetailerStatusResponse? retailerStatus =
          await AuthHelper.getRetailerStatus(ref);
      final String getNavigationRoute =
          await AuthHelper.getNavigationByRetailerStatus(
            retailerStatus: retailerStatus!,
          );
      return getNavigationRoute;
    } else {
      // Navigate to PAN GST Page
      return AppAuthRoutes.whitelistingPan.name;
    }
  }
}
