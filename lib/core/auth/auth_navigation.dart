import 'package:flutter/foundation.dart';

/// Bumps when login/logout completes so [GoRouter.redirect] runs again.
final ValueNotifier<int> authNavigationRevision = ValueNotifier<int>(0);

void notifyAuthNavigationChanged() {
  authNavigationRevision.value = authNavigationRevision.value + 1;
}
