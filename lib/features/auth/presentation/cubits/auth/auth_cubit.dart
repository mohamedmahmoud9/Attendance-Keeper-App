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
    final isSignIn = await isSignedInUseCase();
    isSignIn.fold(
      (l) => emit(AuthFailure()),
      (r) async {
        final userIdEither = await getCurrentUserIdUseCase();
        userIdEither.fold(
          (l) => emit(AuthFailure()),
          (userId) => emit(AuthSuccess(user: UserEntity(userId: userId))),
        );
      },
    );
  }

  Future<void> signedIn() async {
    emit(AuthLoading());
    final userIdEither = await getCurrentUserIdUseCase();
    userIdEither.fold(
      (l) => emit(AuthFailure()),
      (userId) => emit(AuthSuccess(user: UserEntity(userId: userId))),
    );
  }

  Future<void> signedOut() async {
    emit(AuthLoading());
    final result = await signOutUseCase();
    result.fold(
      (l) => emit(AuthFailure()),
      (r) => emit(AuthInitial()),
    );
  }
}
