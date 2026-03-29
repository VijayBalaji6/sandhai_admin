import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/core/network/core/api_exception.dart';
import 'package:sandhai_admin/core/network/core/api_result.dart';
import 'package:sandhai_admin/core/network/dtos/user_address_model.dart';
import 'package:sandhai_admin/core/network/dtos/user_model.dart';
import 'package:sandhai_admin/core/network/repository/users_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({UsersRepository? repository})
    : _repository = repository ?? UsersRepository(),
      super(const UsersState()) {
    on<UsersFetchRequested>(_onFetchRequested);
    on<UsersMessageCleared>(_onMessageCleared);
  }

  final UsersRepository _repository;

  Future<void> _onFetchRequested(
    UsersFetchRequested event,
    Emitter<UsersState> emit,
  ) async {
    emit(
      state.copyWith(
        status: UsersStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final ApiResult<List<UserModel>> result = await _repository.fetchUsers(
      orderBy: 'created_at',
      ascending: false,
    );

    await result.when(
      success: (List<UserModel> users) async {
        final Map<String, List<UserAddressModel>> addressesByPhone =
            <String, List<UserAddressModel>>{};
        final List<String> addressLoadFailures = <String>[];

        for (final UserModel user in users) {
          final ApiResult<List<UserAddressModel>> addressResult =
              await _repository.fetchAddressesByUserPhone(user.phone);

          addressResult.when(
            success: (List<UserAddressModel> addresses) {
              addresses.sort((a, b) {
                if (a.isDefault == b.isDefault) return 0;
                return a.isDefault ? -1 : 1;
              });
              addressesByPhone[user.phone] = addresses;
            },
            failure: (ApiException e) {
              addressesByPhone[user.phone] = <UserAddressModel>[];
              addressLoadFailures.add('${user.phone}: ${e.message}');
            },
          );
        }

        emit(
          state.copyWith(
            status: UsersStatus.loaded,
            users: users,
            addressesByPhone: addressesByPhone,
            errorMessage: addressLoadFailures.isEmpty
                ? null
                : 'Some addresses could not be loaded: ${addressLoadFailures.first}',
            clearError: addressLoadFailures.isEmpty,
            clearSuccess: true,
          ),
        );
      },
      failure: (ApiException exception) {
        emit(
          state.copyWith(
            status: UsersStatus.failure,
            errorMessage: exception.message,
            clearSuccess: true,
          ),
        );
      },
    );
  }

  void _onMessageCleared(UsersMessageCleared event, Emitter<UsersState> emit) {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
