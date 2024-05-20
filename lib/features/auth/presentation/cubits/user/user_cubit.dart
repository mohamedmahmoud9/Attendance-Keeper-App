import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/get_create_current_user_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUseCase;

  UserCubit({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.getCreateCurrentUserUseCase,
  }) : super(UserInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final jobController = TextEditingController();

  Future<void> submitSignIn({required UserEntity user}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(UserLoading());
    final Either<Failure, Unit> result = await signInUseCase(user);
    result.fold(
      (Failure l) => emit(UserFailure(message: l.toString())),
      (Unit r) => emit(UserSuccess(userId: user.userId!)),
    );
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(UserLoading());

    final Either<Failure, Unit> result = await signUpUseCase(user);
    result.fold(
      (Failure l) => emit(UserFailure(message: l.toString())),
      (Unit r) {
        getCreateCurrentUserUseCase(user);
        emit(UserSuccess(userId: user.userId!));
      },
    );
  }
}
