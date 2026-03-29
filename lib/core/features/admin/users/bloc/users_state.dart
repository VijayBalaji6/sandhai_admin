part of 'users_bloc.dart';

enum UsersStatus { initial, loading, loaded, failure }

final class UsersState extends Equatable {
  const UsersState({
    this.status = UsersStatus.initial,
    this.users = const [],
    this.addressesByPhone = const <String, List<UserAddressModel>>{},
    this.errorMessage,
    this.successMessage,
  });

  final UsersStatus status;
  final List<UserModel> users;
  final Map<String, List<UserAddressModel>> addressesByPhone;
  final String? errorMessage;
  final String? successMessage;

  UsersState copyWith({
    UsersStatus? status,
    List<UserModel>? users,
    Map<String, List<UserAddressModel>>? addressesByPhone,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      addressesByPhone: addressesByPhone ?? this.addressesByPhone,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    users,
    addressesByPhone,
    errorMessage,
    successMessage,
  ];
}
