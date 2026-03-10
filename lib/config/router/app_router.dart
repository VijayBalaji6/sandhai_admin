import 'package:go_router/go_router.dart';

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
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            DashboardShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.products,
                builder: (context, state) => const ProductsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.currentOrders,
                builder: (context, state) => const CurrentOrdersPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.orderHistory,
                builder: (context, state) => const OrderHistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.shop,
                builder: (context, state) => const ShopPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.users,
                builder: (context, state) => const UsersPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
