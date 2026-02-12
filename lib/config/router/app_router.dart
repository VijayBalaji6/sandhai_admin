import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/features/home/bloc/dashboard_cubit.dart';
import '../../core/features/home/view/dashboard_page.dart';
import '../../core/features/products/view/products_page.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.dashboard,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => DashboardCubit()..load(),
            child: const DashboardPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.products,
        builder: (context, state) => const ProductsPage(),
      ),
    ],
  );
}
