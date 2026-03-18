part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

final class UsersFetchRequested extends UsersEvent {
  const UsersFetchRequested();
}

final class UsersMessageCleared extends UsersEvent {
  const UsersMessageCleared();
}
