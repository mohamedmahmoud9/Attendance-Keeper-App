part of 'user_data_cubit.dart';

sealed class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

final class UserDataInitial extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final UserEntity user;

  const UserDataLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDataLoading extends UserDataState {}

class UserDataError extends UserDataState {
  final String message;

  const UserDataError({required this.message});

  @override
  List<Object> get props => [message];
}
