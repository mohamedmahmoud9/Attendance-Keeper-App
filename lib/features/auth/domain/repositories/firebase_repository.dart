import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, Unit>> signin(UserEntity userEntity);
  Future<Either<Failure, Unit>> signup(SignUpParams signUpParams);
  Future<Either<Failure, Unit>> signout();
  Future<Either<Failure, String?>> getCurrentUId();
  Future<Either<Failure, Unit>> getCreateCurrentUser(UserEntity user);
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
