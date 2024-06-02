part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required this.message});
}

final class SignUpSuccess extends SignUpState {
  final UserCredential userCredential;

  const SignUpSuccess({required this.userCredential});
}
