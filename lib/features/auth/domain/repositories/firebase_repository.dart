import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, User>> autoSignin(NoParams params);
  Future<Either<Failure, UserCredential>> signin(SignInParams signInParams);
  Future<Either<Failure, UserCredential>> signup(SignUpParams signUpParams);
  Future<Either<Failure, Unit>> signout(NoParams params);
}

class SignUpParams {
  final String name;
  final String jobTitle;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpParams({
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'jobTitle': jobTitle,
      'email': email,
    };
  }
}

class SignInParams {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
    };
  }
}
