part of 'auto_sign_in_cubit.dart';

sealed class AutoSignInState extends Equatable {
  const AutoSignInState();

  @override
  List<Object> get props => [];
}

final class AutoSignInInitial extends AutoSignInState {}

final class AutoSignInLoading extends AutoSignInState {}

final class AutoSignInSuccess extends AutoSignInState {
  final User user;
  const AutoSignInSuccess({required this.user});
}

final class AutoSignInError extends AutoSignInState {
  final String message;
  const AutoSignInError({required this.message});
}

