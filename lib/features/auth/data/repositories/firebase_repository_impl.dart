import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/data/datasources/firebase_remote_data_source.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:attendance_keeper/features/auth/domain/repositories/firebase_repository.dart';
import 'package:dartz/dartz.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final signedIn = await firebaseRemoteDataSource.isSignedIn();
      return right(signedIn);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signin(SignInParams signInParams) async {
    try {
      await firebaseRemoteDataSource.signin(signInParams);
      return right(unit);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signup(SignUpParams signUpParams) async {
    try {
      await firebaseRemoteDataSource.signup(signUpParams);
      return right(unit);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signout() async {
    try {
      await firebaseRemoteDataSource.signout();
      return right(unit);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCreateCurrentUser(
      SignUpParams signUpParams) async {
    try {
      final userEntity =
          await firebaseRemoteDataSource.getCreateCurrentUser(signUpParams);
      return right(userEntity);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getCurrentUserId() async {
    try {
      final userId = await firebaseRemoteDataSource.getCurrentUserId();
      return right(userId);
    } catch (e) {
      return left(ServerFailure());
    }
  }
}
