import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:attendance_keeper/injection_container.dart';
import 'package:attendance_keeper/features/auth/presentation/cubits/auto_sign_in/auto_sign_in_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../domain/repositories/firebase_repository.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpCubit({
    required this.signUpUseCase,
  }) : super(SignUpInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(SignUpLoading());
    final result = await signUpUseCase(SignUpParams(
      name: nameController.text,
      jobTitle: jobTitleController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    ));
    result.fold((Failure failure) {
      emit(SignUpError(
        message: failure.message,
      ));
    }, (userCredential) {
      if (userCredential.user != null) {
        sl<AutoSignInCubit>().emitSignIn(userCredential.user!);
      }
      
      emit(SignUpSuccess(userCredential: userCredential));
    });
  }
}
