import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/auto_sign_in/auto_sign_in_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase signOutUseCase;
  SignOutCubit({required this.signOutUseCase}) : super(SignOutInitial());

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await signOutUseCase(NoParams());
    result.fold((failure) => emit(SignOutError(message: failure.message)), (_) {
      sl<AutoSignInCubit>().emitSignOut();
      emit(SignOutSuccess());
    });
  }
}
