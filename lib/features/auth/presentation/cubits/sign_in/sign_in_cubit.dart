import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../domain/repositories/firebase_repository.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  SignInCubit({
    required this.signInUseCase,
  }) : super(SignInInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(SignInLoading());
    final result = await signInUseCase(SignInParams(
        email: emailController.text, password: passwordController.text));
    result.fold(
      (Failure failure) {
        emit(SignInError(
          message: failure.message,
        ));
      },
      (userCredential) => emit(SignInSuccess(userCredential: userCredential)),
    );
  }
}
