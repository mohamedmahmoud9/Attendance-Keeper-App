import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, Unit>> signin(UserEntity userEntity);
  Future<Either<Failure, Unit>> signup(UserEntity userEntity);
  Future<Either<Failure, Unit>> signout();
  Future<Either<Failure, String?>> getCurrentUId();
  Future<Either<Failure, Unit>> getCreateCurrentUser(UserEntity user);
}
