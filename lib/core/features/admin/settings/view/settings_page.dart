import 'package:flutter/material.dart';
import '../../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../common/widgets/custom_scaffold/custom_scaffold.dart';
import '../../../../auth/auth_repository_scope.dart';
import '../../../../network/dtos/admin_auth_user.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final AdminAuthUser? admin = AuthRepositoryScope.of(context).currentAdmin;

    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          if (admin != null) ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                child: Icon(
                  Icons.person_outline,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              title: Text(
                admin.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                admin.email,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
            if (admin.phone != null && admin.phone!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  admin.phone!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
              ),
            const Divider(height: 32),
          ],
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.logout_rounded, color: scheme.error),
            title: Text(
              'Sign out',
              style: TextStyle(
                color: scheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('You will need OTP to sign in again'),
            onTap: () {
              AuthRepositoryScope.of(context).signOut();
              // GoRouter redirect sends unauthenticated users to /login.
            },
          ),
        ],
      ),
    );
  }
}
