import 'package:flutter/material.dart';

import '../network/repository/auth_repository.dart';

/// Provides [AuthRepository] to the widget tree (login, settings sign-out, etc.).
class AuthRepositoryScope extends InheritedWidget {
  const AuthRepositoryScope({
    super.key,
    required this.repository,
    required super.child,
  });

  final AuthRepository repository;

  static AuthRepository of(BuildContext context) {
    final AuthRepositoryScope? scope =
        context.dependOnInheritedWidgetOfExactType<AuthRepositoryScope>();
    assert(scope != null, 'AuthRepositoryScope not found in tree');
    return scope!.repository;
  }

  @override
  bool updateShouldNotify(AuthRepositoryScope oldWidget) =>
      !identical(oldWidget.repository, repository);
}
