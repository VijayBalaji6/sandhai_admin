import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/common/utils/toast_utils.dart';
import 'package:sandhai_admin/core/network/dtos/user_address_model.dart';
import 'package:sandhai_admin/core/network/dtos/user_model.dart';

import '../../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../common/widgets/custom_scaffold/custom_scaffold.dart';
import '../bloc/users_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late final UsersBloc _usersBloc;

  @override
  void initState() {
    super.initState();
    _usersBloc = UsersBloc()..add(const UsersFetchRequested());
  }

  @override
  void dispose() {
    _usersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersBloc>.value(
      value: _usersBloc,
      child: BlocConsumer<UsersBloc, UsersState>(
        listener: (BuildContext context, UsersState state) {
          if (state.errorMessage != null) {
            ToastUtils.showErrorToast(state.errorMessage!);
            _usersBloc.add(const UsersMessageCleared());
          }
          if (state.successMessage != null) {
            ToastUtils.showSuccessToast(state.successMessage!);
            _usersBloc.add(const UsersMessageCleared());
          }
        },
        builder: (BuildContext context, UsersState state) {
          return CustomScaffold(
            appBar: CustomAppBar(
              title: 'Users',
              trailingWidget: [
                IconButton(
                  onPressed: state.status == UsersStatus.loading
                      ? null
                      : () => _usersBloc.add(const UsersFetchRequested()),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                _usersBloc.add(const UsersFetchRequested());
                await Future<void>.delayed(const Duration(milliseconds: 250));
              },
              child: _buildUsersBody(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUsersBody(UsersState state) {
    if (state.status == UsersStatus.loading && state.users.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.users.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 140),
          Center(child: Text('No users found')),
        ],
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: state.users.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        final UserModel user = state.users[index];
        final List<UserAddressModel> addresses =
            state.addressesByPhone[user.phone] ?? const <UserAddressModel>[];

        return Card(
          child: ListTile(
            onTap: () => _showAddressPopup(user, addresses),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            title: Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Multiple addresses are supported for this phone',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(user.phone),
                if ((user.email ?? '').trim().isNotEmpty) Text(user.email!),
                const SizedBox(height: 2),
                Text(
                  'Addresses: ${addresses.length} • Tap to view',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        );
      },
    );
  }

  Future<void> _showAddressPopup(
    UserModel user,
    List<UserAddressModel> addresses,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${user.name} Addresses'),
          content: SizedBox(
            width: 620,
            height: 340,
            child: addresses.isEmpty
                ? const Center(child: Text('No addresses found'))
                : Scrollbar(
                    thumbVisibility: true,
                    child: ListView.separated(
                      itemCount: addresses.length,
                      separatorBuilder: (_, _) => const Divider(height: 12),
                      itemBuilder: (BuildContext context, int index) {
                        final UserAddressModel address = addresses[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2, right: 8),
                              child: Icon(Icons.location_on_outlined, size: 18),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(address.addressLine),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Pincode: ${address.pincode}',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (address.latitude != null &&
                                      address.longitude != null) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      'Lat: ${address.latitude}, Lng: ${address.longitude}',
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (address.isDefault)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Default',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
