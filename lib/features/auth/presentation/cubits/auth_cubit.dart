import 'dart:io';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/get_current_user_id_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/is_signed_in_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUserIdUseCase getCurrentUserIdUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit(
      {required this.getCurrentUserIdUseCase,
      required this.isSignedInUseCase,
      required this.signOutUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignedInUseCase.call();
      if (isSignIn) {
        final userId = await getCurrentUserIdUseCase.call();
        emit(AuthSuccess(user: UserEntity(userId: userId)));
      } else {
        emit(const AuthFailure(message: 'No user found'));
      }
    } on SocketException catch (_) {
      emit(const AuthFailure(
          message: 'No internet connection ***App Started***'));
    }

    Future<void> signedIn() async {
      try {
        final userId = await getCurrentUserIdUseCase.call();
        emit(AuthSuccess(user: UserEntity(userId: userId)));
      } on SocketException catch (_) {
        emit(const AuthFailure(
            message: 'No internet connection ***Signed In***'));
      }
    }

    Future<void> signedOut() async {
      try {
        await signOutUseCase.call();
        emit(const AuthFailure(message: 'User signed out'));
      } on SocketException catch (_) {
        emit(const AuthFailure(
            message: 'No internet connection ***Signed Out***'));
      }
    }
  }
}
