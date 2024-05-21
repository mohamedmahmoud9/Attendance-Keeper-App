part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  // final String userId;
  // const UserSuccess({required this.userId});
}

class UserFailure extends UserState {
  final String message;
  const UserFailure({required this.message});
}
