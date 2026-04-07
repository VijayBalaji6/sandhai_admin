import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sandhai_admin/core/auth/auth_navigation.dart';
import 'package:sandhai_admin/core/features/admin/report/view/report_page.dart';
import 'package:sandhai_admin/core/features/admin/settings/view/settings_page.dart';
import 'package:sandhai_admin/core/features/auth/login/view/otp_verify_page.dart';
import 'package:sandhai_admin/core/features/auth/login/view/phone_login_page.dart';
import 'package:sandhai_admin/core/network/auth/admin_auth_session.dart';

import '../../core/features/dashboard/view/dashboard_shell.dart';
import '../../core/features/admin/orders/view/current_orders_page.dart';
import '../../core/features/admin/history/view/order_history_page.dart';
import '../../core/features/admin/products/view/products_page.dart';
import '../../core/features/admin/shop/view/shop_page.dart';
import '../../core/features/splash/view/splash_page.dart';
import '../../core/features/admin/users/view/users_page.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authNavigationRevision,
    redirect: _redirect,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) =>
            const PhoneLoginPage(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (BuildContext context, GoRouterState state) {
          final Object? extra = state.extra;
          final String phone = extra is String ? extra.trim() : '';
          return OtpVerifyPage(phone: phone);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) =>
            DashboardShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.products,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProductsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.currentOrders,
                builder: (BuildContext context, GoRouterState state) =>
                    const CurrentOrdersPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.orderHistory,
                builder: (BuildContext context, GoRouterState state) =>
                    const OrderHistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.shop,
                builder: (BuildContext context, GoRouterState state) =>
                    const ShopPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.users,
                builder: (BuildContext context, GoRouterState state) =>
                    const UsersPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.settings,
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.report,
                builder: (BuildContext context, GoRouterState state) =>
                    const ReportPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static String? _redirect(BuildContext context, GoRouterState state) {
    final String path = state.uri.path;

    if (path == AppRoutes.otp) {
      final Object? extra = state.extra;
      final bool validPhone = extra is String && extra.trim().isNotEmpty;
      if (!validPhone) {
        return AppRoutes.login;
      }
    }

    final bool loggedIn = AdminAuthSession.isSignedIn;
    final bool isSplash = path == AppRoutes.splash;
    final bool isLogin = path == AppRoutes.login;
    final bool isOtp = path == AppRoutes.otp;
    final bool isAuthRoute = isLogin || isOtp;

    if (loggedIn) {
      if (isSplash || isAuthRoute) {
        return AppRoutes.products;
      }
      return null;
    }

    if (isAuthRoute || isSplash) {
      return null;
    }

    return AppRoutes.login;
  }
}
