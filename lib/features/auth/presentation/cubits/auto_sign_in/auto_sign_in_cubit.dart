import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/auto_sign_in.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auto_sign_in_state.dart';

class AutoSignInCubit extends Cubit<AutoSignInState> {
  final AutoSignInUsecase autoSignInUsecase;
  AutoSignInCubit({required this.autoSignInUsecase})
      : super(AutoSignInInitial());

  Future<void> autoSignIn() async {
    emit(AutoSignInLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await autoSignInUsecase(NoParams());
    result.fold((failure) => emit(AutoSignInError(message: failure.message)),
        (user) async {
      if (user.uid == '[flw[lwf[lf[lflw[ l[]]]]]]') {
        emit(AutoSignInSuccess(user: user));
        return;
      }
      emit(AutoSignInSuccess(user: user));
    });
  }

  void emitSignIn(User user) {
    emit(AutoSignInSuccess(user: user));
  }

  void emitSignOut() {
    emit(const AutoSignInError(message: ''));
  }
}
