import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/data/datasources/firebase_remote_data_source.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> signin(
      SignInParams signInParams) async {
    try {
      return right(await firebaseRemoteDataSource.signin(signInParams));
    } on FirebaseAuthException catch (error) {
      return left(FirbaseAuthFailureHelper.getFailure(error.code));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signup(
      SignUpParams signUpParams) async {
    try {
      return right(await firebaseRemoteDataSource.signup(signUpParams));
    } on FirebaseAuthException catch (error) {
      return left(FirbaseAuthFailureHelper.getFailure(error.code));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> autoSignin() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> signout() {
    throw UnimplementedError();
  }
}
