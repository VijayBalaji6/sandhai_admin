part of 'users_bloc.dart';

enum UsersStatus { initial, loading, loaded, failure }

final class UsersState extends Equatable {
  const UsersState({
    this.status = UsersStatus.initial,
    this.users = const [],
    this.errorMessage,
    this.successMessage,
  });

  final UsersStatus status;
  final List<UserModel> users;
  final String? errorMessage;
  final String? successMessage;

  UsersState copyWith({
    UsersStatus? status,
    List<UserModel>? users,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [status, users, errorMessage, successMessage];
}
