import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/core/network/core/api_exception.dart';
import 'package:sandhai_admin/core/network/core/api_result.dart';
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

    result.when(
      success: (List<UserModel> users) {
        emit(
          state.copyWith(
            status: UsersStatus.loaded,
            users: users,
            clearError: true,
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
