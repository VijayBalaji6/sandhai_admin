import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'constants/app_strings.dart';
import 'core/auth/auth_repository_scope.dart';
import 'core/features/admin/shop_selection/cubit/admin_shop_selection_cubit.dart';
import 'core/network/repository/auth_repository.dart';

class SandhaiAdminApp extends StatelessWidget {
  const SandhaiAdminApp({super.key});

  static final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: AuthRepositoryScope(
        repository: _authRepository,
        child: BlocProvider<AdminShopSelectionCubit>(
          create: (BuildContext context) =>
              AdminShopSelectionCubit()..load(),
          child: MaterialApp.router(
            title: AppStrings.appName,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.system,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

